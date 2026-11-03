Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716276;
	b=18xmzqVScyvCAeleO9HFRL5SD9kbbrkX2FEA07kdn2rbF9HNORBSVRMeKsxMSq2UBsuG
	 BrZdLR81SpOM+ms4D+R8cJubkMeYc3QUaE99zT9NGSktLXXy7vNjc4VywcNK2ADTGSAUj
	 h6VUVPpcWwklmKB5t+Pe7jZ5o3qR6D5ErXFnI4ksHPUNjE4os3zFxit/sRfvaBVdh8hJn
	 3vBk8xVRqkjKWphaI7iXAeNabMrWo50+J1yAz92rhtq2FuJgYqBxBgRvu2JDPbeBM1e+d
	 4ze5Sc9xc4NK4BHNmimjmo8wAIPJ2ZJa91YUm9W4rdgrEBo+AjOavnvZtww7iITTxmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=7gHNoWmTfmQOSG4KOSEWfHiqr4reWyCq9KH7l8wRe3s=;
	b=e9cf1S8+86+nKjnnkwk3WrHsBBxURTroiJjj7iYgL2o+PsOBNi7OiW7yrmGcY2xvgvcf
	 fWYeyMqt0DaTZcEINVrmI1xacNEsmUWd5DswpyDH6Vku4g/jkVYBNyXA+InNrti+0aHV9
	 C4tbwgOLwXsYZ+8TcGoFpihCTqbcu+yIl57evePbaxpxLDv2Spa0ZMr8vKJKIdDrCCs7h
	 JLUuC7h9a7eK4EDAE0z5981558rg89Zs61Yy7oql6mTmeOHDXemqzSNBWDVGFaP1dM+61
	 bYJhm0fnLuYQJkLHbMJKHd2VYIU4gA6q9YnByRGJX8DHpjikG6djqjPhpOwnsjYmdDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UD1Vo4w3;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB86082BC0
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EB86082BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UD1Vo4w3
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1931ff67a29so8730934c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716275; x=1794321075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gHNoWmTfmQOSG4KOSEWfHiqr4reWyCq9KH7l8wRe3s=;
        b=UD1Vo4w3gZhfJtogWZQDD61Mxt2SSZ+1t62Lk8dMZD1ytyuke5jYQNUnvGV7Ro9jTb
         X6CV6HnzlZrMW52dOsL7ElRhIH2rmmVYxpCMyMzkVZTuHsPzwOTcWaP1VATRRuZrEpo1
         b4FIACf2S62DY+fyl3zqXQRPcTHO48tj+COqLBMs3so6xPDqPIrtSfcW5fo55y22M1LD
         ZLUisuhsSSYN4xON2yqH36Q2JPgvnM7TJViD/2ePJqaRKE/vDpu6spk0WEFBk/khZua2
         +wgo9A8BrOL/39hm5EX4uzsovKHF/OAhTmHo4YysjFdqKQUGo3eXDvMhcwW6QykucZra
         fTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716275; x=1794321075;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gHNoWmTfmQOSG4KOSEWfHiqr4reWyCq9KH7l8wRe3s=;
        b=VIMIN+Xiz+mmXF6CVYiDuTBt5+NQQIMZY/oVdcEC2q/HulpsHodA1pWzb11vMwhF9p
         ApAWednSP59QymgtPK1fLK5dDmOkGo+lMbEuYSAlEot09T6KAa+Uk3kzY1T1mVHKW0QS
         KXe9rL8udO8gjbXmRGU3YxGWkZpzEQaTMlH2NdRCbYaF0WzW+tzCg/NgosHL0Ix3j++Z
         bNDzA0nPiiygmpaSqKVWW/ZJSG17SfRM3ipGwM7GgWGpfc9HWnn1HjcnbBLn3WwKwUO/
         M1SkudTh+jZedWyktm+jto/3CQXjUxnfGvdibDs6/e1rXtGDQELkrTylMjwFSe+3/Ysx
         p1qw==
X-Gm-Message-State: APuU4Z9yPxw8j7KtuvOAWqG2QEgK+4YjvjhcAQcObTKRYap1sOGtGp8S
	TTh2M1rpl7x6eK3DgElnwc8bZlBd90YU2LgecJB6ngpiEfsTO9BSw7AHP2GE+6gxCNc=
X-Gm-Gg: AYBFou3JeDeuk+XQ9WHyxshF4GXzvc0ljRxDdjaEDM39OriNQSoj/gGQ9TKXCMGPGKp
	Tmy0AAkzDSHqB1nP+WjudKERppThaaSSbE8JPsUNSE7hUQLVXitaQb/q9JNKkUmSEdwUPcKveC5
	2zbMmE/w4m2Y1SVNBZ839OvrhXW87nouIAI/JyNVNqzo0ety65BFm+i2maortt8rfxsZacuUOu/
	nxrTnGbp9RdAkhdBKbIaM3xHSdy+cCB+w4skNYH7fHXNSoBPkLZ3t7F0hBTXuk55C38Izu1cibf
	cHYHic4eQmvHGoMv120rtBLeoLYboux4gfl186W/RpF0d7aWemuoeH9/3cAIl7c21NZB56JkAI8
	saqXMO83tDF5fHabMFmDzRGDURl01ClWT6RBwYYNjYevV690KofpXMT5zlEXPAknx9laC7SjBuw
	0qP1rOC9/AaFFPH6ExS675qC25yk1dRmXHzkW5gySe4G4MZpO8pn9mvDwfgioU16K2F0fhRNrwi
	5Q1T9LRWTThwS65TwjmBadg9mWBavSbcn3rDaUbj/GcS0pxq+1ccy3FU1ZPYy08RIjlvuMDbQvQ
	3+EOKNIfNOV90YJmXR13CZDQ/heWj9pXiHVnp+6U4ueF+x+6+oK5G6aODRdgpoD7MvKTKe+8ns5
	aq1iQioMQt7Oz
X-Received: by 2002:a05:7022:3a06:b0:1a5:1c15:9ea3 with SMTP id a92af1059eb24-1ac5ac4b77amr21046296c88.17.1793716274970;
        Tue, 03 Nov 2026 06:31:14 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, mkp@kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261031102023.3644494-2-thnkslprpt@gmail.com>
References: <20261031102023.3644494-2-thnkslprpt@gmail.com>
Subject: Re: [PATCH] block: report the correct discard alignment in sysfs
Message-Id: <179371627406.3691261.9915846526191615476.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:14 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 31 Oct 2026 12:20:24 +0200, Avi Weiss wrote:
> disk_discard_alignment_show() reports the physical I/O alignment offset
> instead of the discard alignment. Devices can specify these offsets
> independently, so the discard_alignment sysfs attribute can report the
> wrong value.
> 
> Use bdev_discard_alignment() for the whole-disk attribute, as is already
> done for partitions.
> 
> [...]

Applied, thanks!

[1/1] block: report the correct discard alignment in sysfs
      commit: 2516f0413f8704a7370ef8a2eeae26c9bc438978

Best regards,
-- 
Jens Axboe



