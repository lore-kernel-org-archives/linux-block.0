Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704EC1D5177
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381750; cv=none; b=suzZn+RqYhHOICl0I1rQX9Gx9HXN7QjDVpoUgtf+pjRBck6cDsmUIRXkoKiMlBqUCJSJEY2HEWhMvpCbhFqeF+R7FyCCKn0FV5fJU6jtPyV2RpGJrp38YX52H8wl9x+UZpKECUqpousQM1GCTCWz/86cAsyar5IQccB6QQzBsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381750; c=relaxed/simple;
	bh=s2y2/hWY7AWAxvg7r6xOBvay0ppLgmIwGGyEUUh8uFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtwTLa2rBwxHpC5Yl9+2Pkn8cpl9elLYaN6KEwNTTw/y4/oH2nf7DljEsijjMzHh3fF4O+quQhnPj/hjh/z9FuI5iwx1v6NSedLIc2Fhgq73dLmLLH2UdqpkKmzLnsIodVG0YeixVUXHwYh45A4/ML3c/hIEgCg6U/PdE03YCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZVWd62bI; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZVWd62bI"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBsM66Hgrz6Cr2Gn;
	Mon, 16 Dec 2024 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734381744; x=1736973745; bh=GP1naey2CaImkW97gBpmwhui
	LyB1DWi0Dto0rWWQSLk=; b=ZVWd62bIqBSM7kVGawkCF6SQ4CA6uDG2WHXq52+8
	SNd9HAqURQOCUOc5ctpSOhhMkuqyBcaDYJ11RrkpTXk3x7IiBbClxhUhvoJz6WdQ
	B1jW1t1KTLLBQko/HBYn+AT/N6sIUkH2cn8CcdAMLlk9/aHntoNJoUdo5jhvhZ3n
	urMTTbUESM3p1Ry8XMbxKhPX3/N6TP4VDBqH33iqJcPh4L0duTHhh3XCFPiK4mam
	lqPszuxwGMDKvP3czbi4lHrFD2XbzO1QcGXQd/qz91nb9Vih0g97UAZ94RKRVP7D
	HRj+ByR6e0nI/mm2MG2kEiNnK7/ZLF/CZ4IAkI0UgEFIRw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ohmYRqogqgLZ; Mon, 16 Dec 2024 20:42:24 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBsM41TW4z6ClY94;
	Mon, 16 Dec 2024 20:42:23 +0000 (UTC)
Message-ID: <ba8caf98-8b09-4494-add8-31381b04cd33@acm.org>
Date: Mon, 16 Dec 2024 12:42:23 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/16/24 12:23 PM, Damien Le Moal wrote:
> On 2024/12/16 11:24, Bart Van Assche wrote:
>> If 'qd=1' is changed into 'qd=2' in tests/zbd/012 then this test fails
>> against all kernel versions I tried, including kernel version 6.9. Do
>> you agree that this test should pass? If you agree with this, do you
>> agree that the only solution is to postpone error handling of zoned
>> writes until all pending zoned writes have completed and only to
>> resubmit failed writes after all pending writes have completed?
> 
> Well, of course: if one write fails, the target zone write pointer will not
> advance as it should have, so all writes for the same zone after the failed one
> will be unaligned and fail. Is that what you are talking about ?
> 
> With the fixes applied to rc3, the automatic error recovery in the block layer
> is gone. So it is up to the user (FS, DM or application) to do the right thing.

Hi Damien,

For non-zoned storage the BLK_STS_RESOURCE status is not reported to the
I/O submitter (filesystem). The BLK_STS_RESOURCE status causes the block
layer to retry a request. For zoned storage if the block driver reports
the BLK_STS_RESOURCE status and if QD > 1 then the submitter
(filesystem) has to retry the I/O. Isn't that inconsistent? Solving this
inconsistency is one reason why I would like to postpone handling of
zoned write errors until all pending I/O has either completed or failed.
Another reason is that this behavior change is an essential step towards
supporting write pipelining. If multiple zoned writes are outstanding,
and the block driver postpones execution of any of these writes (unit
attention, BLK_STS_RESOURCE, ...) then any zoned writes must only be
resubmitted after all pending zoned writes have either completed or failed.

Thanks,

Bart.
