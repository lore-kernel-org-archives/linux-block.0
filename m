Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F738735A
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053265; cv=none; b=PIyjQ1+9qdXJ9EE6ucP7vyI6orVPjn9LCgUckjLaiSPRFj5tS4j7F5LGwQOtNogXxkQLK5VTUOpp5jA+7c6XajNKS5CAXcjV/1mEa7L61pgKAiljjKM4swRcH6bkB1Fl6NjS3lDlax354xxrT7OIr6EhpJpL73/obbDB1DiyKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053265; c=relaxed/simple;
	bh=20atEx3/P4iNMKWAlADed+bIKkDwteGSQmMERIZ+mG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X4RGGVRpKqgqGbOe1m/Yfvmrxyw3GFo0Vbj3dRrQeRPaXptS+n8DFl4PYxcuR3gQYDiGcjZckqKcmEaLV4tzuXXlKn3dIyd8FXMc4DRtyya2zW8kc8pUsfVPihAOedBOp2xqBgrREvBSiidniZzgutIxn7xmygM9/kr80t1UFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Pu8GrKsd; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Pu8GrKsd"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f4YTk6gKxzlfl7L;
	Mon,  2 Feb 2026 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770053257; x=1772645258; bh=20atEx3/P4iNMKWAlADed+bI
	KkDwteGSQmMERIZ+mG4=; b=Pu8GrKsdTVHVIz9grGNIDD+gqa0JvwB75jtixH5m
	SB1lWh6VBl5okSvmVE7Dc8RzSde6YWqUpSB2AtEm20/zNfGB9WrxjOa1JVmtVkJm
	A5T8r/+SNT2gDml8CRvhsNa5sC1ejIFRJYcSioXBUkrGSK9TTeB/qI92zp5bUgCK
	ExfoEksFFWp0UKBLDuLAUVjO9fFETkTIw1JT2gUwhKot3Hc+WoUHKdZtq51Id5Ie
	a9tn6K2JcTObs5O6oGIXUwpUfP8XgKvAqzGfCCFC3gS2N8Ely1Jig1bHPmXrHUl2
	KAdjPd6XUon+E4h900Ic4/eYinqn/bcN595HXJxFTC6ukQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id p7w3W-3KAHqn; Mon,  2 Feb 2026 17:27:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f4YTh6mDxzlfvpL;
	Mon,  2 Feb 2026 17:27:36 +0000 (UTC)
Message-ID: <923b3b4d-a84e-4a19-8767-6bca59204ff1@acm.org>
Date: Mon, 2 Feb 2026 09:27:35 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Hannes Reinecke <hare@suse.de>, lsf-pc
 <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/26 9:06 AM, Hannes Reinecke wrote:
> While we could easily terminate the controller, the specification
> also requires us to terminate all outstanding commands.
What specification is the above referring to?

Regarding terminating outstanding commands, doesn't how to do this
depend on the storage protocol? Isn't the recommended procedure for
NVMe to delete and re-create all I/O submission and completion queues?
This procedure doesn't require support in the block layer for aborting
individual commands.

Thanks,

Bart.
