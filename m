Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D353A6;
	Mon,  4 Mar 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538423; cv=none; b=NbwxCi0Mx/xauGI51f5cEdDRWq1WMD+Mgk6NKVLisDZ1vFZa4XrcoXuq5AStdrImHKnQKP93gJDEI5PpEKgI753UOxwXg+cnMl+z2OhjyBZZC8haEiktL6nBcvOybe43T3lH8WKKoNIohGwrh/gGa741K8iWsB5J2NW/jNB6wXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538423; c=relaxed/simple;
	bh=kYuDADgxuY7kBX+z2hzyjWgZ4GOjlV8L30E1XRRoGOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EM2FDzJynfYyU5MzIjlc94oD2MAump+qCvv1Jpvvpwt1jm3VPsnwTGczUW0oth9AXFKGHyfKPswpXKNXoApnpKns5dzI6Wfj+HhwOx1UCGBpOi/X0GZ4DjOwjU/lV8Y4+R2is7KgqElBPkW2rcafj7t41c6WYinrZtdRi8e1mng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=LbgZJAtV; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="LbgZJAtV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=kYuDADgxuY7k
	BX+z2hzyjWgZ4GOjlV8L30E1XRRoGOo=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=LbgZJAtVMV7/0TiA+SyrQAlB7UrhKlyaCKEq4N4i
	2L55yNF7HedB3xX+sQCXlJ7Kzs1wJbTVtfZ/X8VXKsCsx4/WCvtZa55eTEVqNpjVPfBoqa
	13TNjO2jqtJWc6WJ4DJGdldnVlF+Uv6v8CEkZo/IPeX19ZUAIXKG90h+N/MJs=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 2ca81bb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 08:46:56 +0100 (CET)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 4247kuAg801660
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Mon, 4 Mar 2024 08:46:56 +0100
Message-ID: <029ff780-902e-42da-a5ed-6c306c6cb2e4@aixigo.com>
Date: Mon, 4 Mar 2024 08:46:56 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: RIP on discard, JMicron USB adaptor
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        Harald Dunkel <harri@afaics.de>
References: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>
 <62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>
 <Zd9Xbz3L6JEvBHHT@kbusch-mbp> <yq1sf1c1h0x.fsf@ca-mkp.ca.oracle.com>
 <7a10ff3b-0c4c-4aa3-8218-02d5f27ab062@afaics.de>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <7a10ff3b-0c4c-4aa3-8218-02d5f27ab062@afaics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

Hi folks,

having some kind of feedback would be nice. Is this a known problem?
User error?

Of course I would be glad to help to track down this problem.

Regards
Harri
