Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D474C66
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579064; cv=none; b=tTsvcCz3x5Cy2zenGcZROzcPORiXngkcbCakY3J52cbAhHT9l2K5Z4BxI0GqGfoewCVJ5xmrWQhR1sG6zdzTnVYd9wPgt5hTTd3QKSoEKDC2FPvuu9n6RZtegMJodH6ZUmSm/FEtlquRCuW3QWOi0viougghYwYRxmPVwv8BBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579064; c=relaxed/simple;
	bh=wD/7M4rj0H7ds8X8e94c5FiPjPQpyI1IzxeHRXIwJTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmTOwHRLLPyPX2ybXo8ayO9PJMdtWN6Wz92wPeqjYWcfPd1emCEwbdCk1cyVZN7i+63GYUM8Q1sxvABmtDctDYgkE6WJQ5WDC8CSaJRagoeAeYBY+aO0m7PE7QCvVRsw0IRXAP0nTudkUp0rliezQCDXP6NmqMhWYvept0cWTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cFr7okSJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cFr7okSJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so58402085e9.0
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726579060; x=1727183860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pk2mdyN3EFovaqsJkfq0M4JLP6lRnVk0RMHb6RCIis0=;
        b=cFr7okSJ7BY+3DZEjz8ac2HnmgPszMMatFThyv+W5KPv4uQuvVBEbMyardIHE2rrBA
         lu8MCkKm1T7oauLGBUwwLeMlzSF4Wbh6CvkvzkeLjLl/KWl0jRPh846n1FoqNwFO1VP+
         9icGB7FumTDmS8ymWQ3SYmBPxc175m1pWjcRKxuOUTsj1BGjZlHAjxYyo9wCkpB/9wAu
         ZlyfmxzZBoz6QOpWJX9duJ2uaCYNnrvth0AvI1A1yAlodh/yS6xxQquGj6oTwBXw8Zdh
         tQUUeWGNpUXDeoXBa03Y7X4uJWfWYMQ9GK1EO+472sSu+8EeGWrh+lc2tQa5tUWFM0i0
         /QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726579060; x=1727183860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk2mdyN3EFovaqsJkfq0M4JLP6lRnVk0RMHb6RCIis0=;
        b=J/XXWY+b22ItRfKpVbVa3HzAUf0/bj2VwjDbBj5OKTPXPJRFw8lsWPIlkAUEbb6gG9
         XFEt68/6y2gN3Zm2Wv0KekN525CRqzPYHLPywBH05NuO9yP1R8gYd3dthJiWqmRakOqy
         S4z7fgtwBNi72efKBQuDc19JRMP3kGBPN1WmYOmQLiw2sFbBb/jLufzWT6bK9bVMKya6
         gQrz0BZFmAPfLBhcLjMjZ7Z+uIbljsWZ/Ln8zxRG5BSV8R6ZXhlM6e43o9NvpkhrRL0Z
         PlBnCp+OKT1Cljv/119jAjXYZHnufuNSTbU3K7x+ZCwNlhwFDD1H4d3EuZoX1UVJIfwx
         +MZw==
X-Forwarded-Encrypted: i=1; AJvYcCWteM7Mbz3mgOSDheolHyjCVKitP6v5kfd8UVjJsTJT8jsCQQO2SX41mg7976kNMLqMndpF/nPwk8bfKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlBcY6KCWS3vMP3MNz4CWSv8pQois7V4I4dBvJBhVTp9S7F7T
	bO3XmdJwFtXNpaIJgxidgk6TcyBD+td+0HeD4QU+rvDxBVD13CDyn8e/AgEY66Q=
X-Google-Smtp-Source: AGHT+IG0L4GJ8QI2pZa7CYG0AIm3gZMKJ1HhZnhzBQwRBonoSWp4qPBpZqUzn6rwoxVX0F03hnJnaw==
X-Received: by 2002:a05:600c:4714:b0:42c:aef3:4388 with SMTP id 5b1f17b1804b1-42d9070a3e7mr163378265e9.6.1726579060042;
        Tue, 17 Sep 2024 06:17:40 -0700 (PDT)
Received: from [10.130.5.220] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b15d5bcsm137046345e9.26.2024.09.17.06.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 06:17:39 -0700 (PDT)
Message-ID: <12fddb25-5046-46df-81e7-7d47de0861cb@kernel.dk>
Date: Tue, 17 Sep 2024 07:17:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 linux-block@vger.kernel.org, "Richard W . M . Jones" <rjones@redhat.com>,
 Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240917053258.128827-1-dlemoal@kernel.org>
 <20240917055331.GA2432@lst.de>
 <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com>
 <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org> <Zul97FvBsVuC1_h3@fedora>
 <20240917130518.GA32184@lst.de>
 <274ec9f3-b8b2-4a0a-bb13-f3705ddc349f@kernel.dk>
 <20240917131450.GA367@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240917131450.GA367@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/24 7:14 AM, Christoph Hellwig wrote:
> On Tue, Sep 17, 2024 at 07:11:22AM -0600, Jens Axboe wrote:
>> Whatever reshuffling people have in mind, that needs to happen AFTER
>> this bug is sorted out.
> 
> Yes.  The fix from Damien will work, but reverting to the old behavior
> of ignoring the request_module return value feel much better.  I can
> prepare a patch, but I didn't want to steal the credits from Damien.

Oh I agree, I think we should just ignore that and that would be the
better patch. My point is just that larger reworking should be done
after the fix, not advocating for a particular solution.

That said, someone did just email me privately because they ran 
into this with 6.11. So we should do a clean simple patch to help
facilitate getting it to -stable sooner rather than later.

-- 
Jens Axboe

