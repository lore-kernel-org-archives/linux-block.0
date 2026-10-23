Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790214;
	b=pJTauN5BIQf0EQwbGRMmndzyi9KbAfIlZkGu4wQxXjWmYEKPgM5hbfzMDo4o3TAjx0bf
	 XwroaQV/nDNhwrAxbpdKfhkx+aozKxAkDf1Fu3JgmoJV7j2mRzR3QDkxKBNmjkAwk1/Is
	 BpIqA0+3fGYKRIHdIUjtT+Bt3MdZM8yfBtCsX4Tl4wtuUc7g9FMQuIITefk6GFr0VlvJO
	 VDsWKo81jmr/sO7wQXC8zpxRd0dgQ329lzFuNpforQyTCjqGVOS7iHrCtgU4nUiUC7iKH
	 Ouucz8tquiPIDogaGfv5hfRHrgIEsC6nfa3NwCnoscFxUMbXWKXz58tptyRzVkIKnZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aEJY3vtZQGObIy5sdvcomN+w3nA+SJi1tavKTizBKOI=;
	b=Ypz47vjod+AWv7jEuHWJ+9wVhcyTqpIRMC52DozUATNgj/U/PlvnrA1zu9NRm7CRW2q0
	 +25xNFzSJrbgC9d+cAx/c8/l/5ErPuvXZSWbECBvPT9GwC+1gbZDA7tW7A3Yl+0QmzxWy
	 /XcagjK932PdH6Z3t5kko9Xk+LmxAdT2zQySNpvolIhL2PpRXDcRDGjw+vGwdQk+8rXYT
	 L6cvfMOB2B1tCuj7nGW2CSCreKAkIrWVQomsAoY+oatrm2YcGEhilb95asXnW6uPUCR4/
	 +I4PXJuvoDDPkR4kVrbrXxil43kNVzx6WHOe/aPzCNo/oY5WRlj9NyEsmQ+Q1dHUJwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=philpotter.co.uk;
	spf=pass smtp.mailfrom=philpotter.co.uk;
	dkim=pass header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Vdyf7yUK;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CB606A31A
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 21:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Vdyf7yUK
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956869750eso8366145e9.2
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1792790212; x=1793395012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aEJY3vtZQGObIy5sdvcomN+w3nA+SJi1tavKTizBKOI=;
        b=Vdyf7yUKD2JPL1JxxWXx5At5xYWn5ri8UNVcVUiDWOp2XFORIY/8g1tct+VaQJWum4
         iZFXCPTnlK6nM3Pd69MXT1iJPwdDMJtqdeb7i/5jhjJGtmQ3wCXbgCgkLTh3ynJuVL2p
         XjjXnoc5BWyxqg9gUhV6FR6uNkgD3XthuykICRcSIWxBqiGw4fiSNWJGZrZBHsT61+/V
         8TjO/cqE4Xa2OMvUNeC+R+4NmXDF9NroR6s859oJ4KBLOLpeSHmKqMyRjs7yeM7m/oUX
         tqr8vw/kq7h96j7CvHlX5q3EBQe73N4qeJY2xcMLBrel+DG6zeNlh1UhydRK3tY1DmN8
         etlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790212; x=1793395012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aEJY3vtZQGObIy5sdvcomN+w3nA+SJi1tavKTizBKOI=;
        b=FUxpVnc0ChI7OAEUWDZp5itLBa3T3veq+mkLj1GwooXTZAVlNMlWF6nivILqTv6QJK
         +7xC6WmTS5BVvMVdoLiC3Cl5vdbh9NEOlo0oT6Hr1ezUijWHS44/f85JwhroP2RPPx0p
         X540kdUfb+l2nFERd06Kp4LgRUZKFRBeZhw8WgTWNsq+ZJXe7LmTNBIh8asN918rJwGy
         zPjv+LupoD3XmovPCn7d6ll3v9Lb37T8dEn0RahPqERsr0sCyeJA2Gy9/9h32PUqkA8t
         SIJDpDqzHtK2ZzGvt05LIWSXbJE4ApkqBsFnOfylJvzZxh93NRHTWgUhmrYA4Qh5cI3G
         MABA==
X-Forwarded-Encrypted: i=1; AKwUvByjuRJ8ZuwNl6uQrx18BasYUpoxikY2Awh/Lk8MCyIA8sNcjXkkOsm8/BCQ/nVssQvWY8TTCl0N6mfDXA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLreL7mGR+qR8uE3etP+mdlZ+bU7XGCH7qJQfqv7pcXpZLifYEg
	FeyW0xNvDu0quYS+4nAuRRuKPJwx6nuFwvzpS9s4R09Eg601ye8c30DpJeTOxfeRQdU=
X-Gm-Gg: AYBFou0kQf6YD5083hDKHgspt/ZACU0EyG+Px4mIY/7X7pWrY1yLeU+pHQqMLnXt1qi
	d3+4KNzkLFow1y4QANU/7GXqPmKXuHOo7SqEOwTnyLFFRTbuSai0CEGyB/1zvy0jrbPUh4OPHsx
	eLy7LjmPCiPZYgb1Oc0Ch68Tt9CWswbRjOLpNy3tJYIZ2X8ATSMNUA32ORuD3V+Bur0lXwN0tZy
	lycjec/3zBcXBWxw5vQCDqcQkzc/1ezY96K97jidI8Kx4CwGAX05OGKaF0kelZ/jo8CbsUvNHpQ
	ZcaEGXJrmsVWMzofLLthOvqI/oa7Fr/ERhoLOFJ2jvbkD4MbbO+RpKFFvo2XtuIdCX7+zE+ZXkz
	C2QN3L5qllWQYSZ5YQab6gutO639q0RcBhBqjq6bIeZnQecA+oVZ4Mlg7SZYdo7p2Csskm9h257
	VgYucj/G7XoXnalXnOqCJF4PoXrbq6Lcmoj2ktOxEWH1HbPeMs3UxAfjGNcmihOCpfP5GnEw8sJ
	En/Z5sQvl7cOQPm7m3UMpYejlk67/rHMaaqUyBmnWM7PO0=
X-Received: by 2002:a05:600c:3b25:b0:4a2:1a:a128 with SMTP id 5b1f17b1804b1-4a35ac9f1ecmr2001535e9.19.1792790212272;
        Fri, 23 Oct 2026 14:16:52 -0700 (PDT)
Received: from equinox ([2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a09434esm9675185e9.0.2026.10.23.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:16:51 -0700 (PDT)
Date: Fri, 23 Oct 2026 22:16:50 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Phillip Potter <phil@philpotter.co.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] scsi: core: update cdrom.h coments
Message-ID: <atvOwu-F8b4ajNOD@equinox>
References: <20261020170603.3692218-1-rdunlap@infradead.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020170603.3692218-1-rdunlap@infradead.org>

On Tue, Oct 20, 2026 at 10:06:03AM -0700, Randy Dunlap wrote:
> Update the location and ending value of the cdrom ioctls.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: "Martin K. Petersen" <mkp@kernel.org>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> 
>  include/scsi/scsi.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20261019.orig/include/scsi/scsi.h
> +++ linux-next-20261019/include/scsi/scsi.h
> @@ -176,7 +176,7 @@ enum scsi_qc_status {
>  /*
>   * Here are some scsi specific ioctl commands which are sometimes useful.
>   *
> - * Note that include/linux/cdrom.h also defines IOCTL 0x5300 - 0x5395
> + * Note that include/uapi/linux/cdrom.h also defines IOCTL 0x5300 - 0x5396.
>   */
>  
>  /* Used to obtain PUN and LUN info.  Conflicts with CDROMAUDIOBUFSIZ */

Hi Randy,

Thanks for the patch. That said, without meaning to be too picky,
strictly speaking the quoted UAPI header file actually defines from
0x5301 onwards unless I'm missing something - perhaps we should change
the start of the range as well? Happy to adjust and forward on with your
other patch if you're happy with that?

Regards,
Phil
