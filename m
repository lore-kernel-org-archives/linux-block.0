Received: from mail.ehvag.de (arnold.ehvag.de [157.180.54.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9744C8FFD
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.54.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323253; cv=none; b=UvV1Mfou4dyTZuRZVwFuo34BPllxfzqtK6sD318aY2H2O5O+mAwtAqslkYv8gRBuAs5yEj/Tb8RPJoCcnpmtqmPakkRnN6s1IS8Y9anXLp69tuQ1Cqvs8KA4+E49GsNgWwsFokuXoGoP/XmAJ1xg/H/dYG/hHBOiyMybRUC29zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323253; c=relaxed/simple;
	bh=sFBtt0ZK/88swZbLOwUPE43U6U0PuIyp9HUsVj+GUJQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Wb46I8fkxgoXT354xUS1S281qqYEt/0whhHEQ1uwVesZLV9cG5Uy0jIPbZvU/3S1QO7LR6gEovbaaNakoTbuFIYHy7Z9yofMq2uxM84GoZ5Jj4mp68ALUwujjWOBKVBfQ/fbC5UDnf7o1A6WX3w37qXFEe1BfONg6jdryMZYIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ehvag.de; spf=pass smtp.mailfrom=ehvag.de; dkim=permerror (0-bit key) header.d=ehvag.de header.i=@ehvag.de header.b=m9NmUJY5; dkim=pass (2048-bit key) header.d=ehvag.de header.i=@ehvag.de header.b=OzU1Pkdj; arc=none smtp.client-ip=157.180.54.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ehvag.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ehvag.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=ehvag.de header.i=@ehvag.de header.b="m9NmUJY5";
	dkim=pass (2048-bit key) header.d=ehvag.de header.i=@ehvag.de header.b="OzU1Pkdj"
DKIM-Signature: v=1; a=ed25519-sha256; s=202603e; d=ehvag.de; c=relaxed/relaxed; r=y;
	h=To:Subject:From:Date:Message-ID; t=1787323109; bh=5oEU72Q3G9Ij1Z2DKkVrwve
	Uf5752wo1+99n2FpFjn4=; b=m9NmUJY5eDch+rIF4R2FOf6Nor0zvgLiwNrVQBAwM/deioRDm6
	TxPjQ2p/++goqxEY3jukNfloEr/i25wPvlBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202603r; d=ehvag.de; c=relaxed/relaxed; r=y;
	h=To:Subject:From:Date:Message-ID; t=1787323109; bh=5oEU72Q3G9Ij1Z2DKkVrwve
	Uf5752wo1+99n2FpFjn4=; b=OzU1Pkdjsj/qX99ogmYIVSFf0uOqqnJ6EyZfmcvvRcAetSkoDJ
	LnQSma83mNwu3aJ7wozMj8jy1lhYDHbedzSl7vGLQEO+WIclHbuUw52UcW4OqG45/OwdQ7VyI2u
	z3CHTcxMux9tCDcb7/TX3Ygy+ngR3WGnajSOuXw5xe9UZ/4T7Nb4/CrT3WvX0DvFgJrSj/4bTVg
	IMCeydkhoUxxVrj8cBL/501jn42rY8FpgRamAUUGZz/rPBn04A3AJmB9W8MU4cZefXKKi03VvTf
	k5Acz7TWDrIXCr9iC9VFW3QtbBow/si8y/PBjJ4dhJk+63PBkY5yGI09EUH3ZYMvs2Q==;
Message-ID: <d5ff28e5-53a3-481c-870f-f6115e82f4ed@ehvag.de>
Date: Fri, 21 Aug 2026 16:38:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Noah Bergbauer <noah@ehvag.de>
Subject: Seagate Flex SMR
To: dlemoal@kernel.org
Cc: linux-block@vger.kernel.org
Content-Language: en-US, de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Seagate Flex SMR drives are an early generation of hybrid SMR (HSMR) 
drives with a configurable zone layout. There are three main challenges 
towards supporting this in the kernel:

1. Instead of CONV they use SEQ_OR_BEFORE (type 4) zones. These permit 
random writes below the write pointer, so once full they behave exactly 
like CONV.
2. In an (in my opinion rather questionable) attempt at backwards 
compatibility the drives camouflage themselves as non-ZBC. Their ZAC 
support can be detected from a special ATA log page but ZBC commands 
must be emulated via ATA PASS-THROUGH as a SAT may refuse zone commands 
on a non-ZBC drive.
3. The zone configuration works by reporting both SEQ_OR_BEFORE and 
SEQWRITE_REQ zones each for the entire disk, and then for each pair of 
overlapping zones only one of them can be active while the other one 
will be in the offline condition. Right now some parts of the kernel 
(e.g. btrfs) don't play well with offline zones.

I implemented all of this last year and in the end everything was 
working fine under btrfs. Now I would like to attempt to get this into 
the kernel. This would involve rewriting most of my patches from 
scratch. So before I invest a lot of time and effort into doing so, my 
question is: would you as the maintainer even be willing to accept these 
changes into the kernel?

Best,
Noah Bergbauer


