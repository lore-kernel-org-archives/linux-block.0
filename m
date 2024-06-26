Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786618EFC7
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422567; cv=none; b=q1Qm3sBTVpNrRrFU+QRpSKMjVdyBkojbZPaQqSbybCCWwSwna7K8CDI9IrbQfAB9kBpYlMkFfedUfVraV9oT6wsE7cfqceEyfCV5TkojuNLv1fLR3jz1KGEwj5DHL7mW3Qz3baZ9wCs3+l2EX3qGLKQXo7LNgs4ZMzUfBvtI0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422567; c=relaxed/simple;
	bh=TmXjNZsCgph7mvapxTGqEn7M1V42hv23k612W/h5Lck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF/RipyLfidsQwyE0E3Zp3b4wIJtI5U17LW8kCu2D08mbe8H7O6VSluKo/UyDhpzQWH6Xv1rHrFduLNfQkoDPHsmx6/nXSGCYDBR99VthsRkEvK6v8XaowwAmLD8m7lHnGliQtnlnl6SueFPz5KK4tfEZQAiK/eqKwsRpSCjShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G4goV47J; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G4goV47J"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so675847a12.0
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1719422565; x=1720027365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dYdob+MqrthkIPr9XioqOhhhcM8Dyq3SfcvaIVFfI8=;
        b=G4goV47JHaC7T8OTas7NVdZXkdm+Uz0kPnXPl+5C8mmadvFF0RCR4LWyllPOVekdpJ
         1yjRRqyNRFWke9gsZtrG75D06RUMzieb/fkgHQQKcQQyQ4oudDUXk01nqf95CAt+iRsk
         ISuOaUcgsLOIMB+nEDs9vaygXrMz7ACoQaKHxmqipoQF5tkNnL3W1yLOtCjbFSyk+emf
         p2s0gnqSOGczyai1FPqCeyfDjLrHFG0GL6GA9t9+Qyz/KQ2Y2kMkmUx6D10Zjfi10u9e
         oNdR0TP31NUtD+w21amwosoGRSX2vbXYFZUNPOE1VZkHf85ssKs2cXHinuJMAxnGkRQB
         myUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422565; x=1720027365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dYdob+MqrthkIPr9XioqOhhhcM8Dyq3SfcvaIVFfI8=;
        b=wkXj/cT2RT2bEdWUgICv0KrFBAMuXGN7NYNSKjuRtjowGyo9KEE2PmFcNcxBL9V92G
         Kgt1j4TYNNfyjIkZCH735ADoUvmL11ei5/nsJwVdn01X2lRU3xCeTTUZL7pnzVQXXQ4D
         Cj3Uyc9PD+eZM/bM1MWZFnHRf9qCJ5eFbLeNeIbrVPcPKIHZ+tFOZ9AxP1GNYP0XIBtB
         jZpBVAMWyv0yPp4lDscaxvKUBX9L9CSPF93ZzAt8LLFGWEBUSdZj209CTlijLvXwvd/Q
         zGx/yFezdVErBwEEJkyXA5nMZ+1W42j/cFvAO4Po+tYw/sx/U3nCVw1LgcDcxKB7hdyJ
         QEqw==
X-Forwarded-Encrypted: i=1; AJvYcCUHuv+dBeQpAE9Lt2FEEksbxgtewX6bAe0lltqWtj6T05N4iwMjctQBP5K7HS9SzywzAzcopT9xGHehRQV7s6edjAHuBdm/6uqUCzU=
X-Gm-Message-State: AOJu0Yy+zb1cmAmtd1cJ6qN2NIL+5/9jeDSYCL6W7YR3p2gUmEMicL59
	yYis4tns9BX8fhGJPMfRQCc+KGtmzTON7AMOIHSlqdRmCXLlUUbCLdlPW50pbe2tM9CZRnf8B3+
	zppBQHwLqVJa2T6zm2wiBpu4mhzlm5y0Q
X-Google-Smtp-Source: AGHT+IHtAFCqGh1QFvq1wxPpbDYrR+kfJEb1a+N6wonhVmQCE/lxC32DtwXziw6+lFkV07dI6oqojYxbMLD3
X-Received: by 2002:a17:90a:2c0e:b0:2c2:ee8e:ceff with SMTP id 98e67ed59e1d1-2c848a5a48bmr14217092a91.24.1719422564897;
        Wed, 26 Jun 2024 10:22:44 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-716b2abc3d5sm569971a12.4.2024.06.26.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:22:44 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7ABA03400B9;
	Wed, 26 Jun 2024 11:22:43 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 83F7CE41459; Wed, 26 Jun 2024 11:22:43 -0600 (MDT)
Date: Wed, 26 Jun 2024 11:22:43 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <ZnxOYyWV/E54qOAM@dev-ushankar.dev.purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
 <ZnDs5zLc5oA1jPVA@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnDs5zLc5oA1jPVA@fedora>

On Tue, Jun 18, 2024 at 10:11:51AM +0800, Ming Lei wrote:
> On Mon, Jun 17, 2024 at 01:44:49PM -0600, Uday Shankar wrote:
> > ublk currently supports the following behaviors on ublk server exit:
> > 
> > A: outstanding I/Os get errors, subsequently issued I/Os get errors
> > B: outstanding I/Os get errors, subsequently issued I/Os queue
> > C: outstanding I/Os get reissued, subsequently issued I/Os queue
> > 
> > and the following behaviors for recovery of preexisting block devices by
> > a future incarnation of the ublk server:
> > 
> > 1: ublk devices stopped on ublk server exit (no recovery possible)
> > 2: ublk devices are recoverable using start/end_recovery commands
> > 
> > The userspace interface allows selection of combinations of these
> > behaviors using flags specified at device creation time, namely:
> > 
> > default behavior: A + 1
> > UBLK_F_USER_RECOVERY: B + 2
> > UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2
> 
> ublk is supposed to support A, B & C for both 1 and both 2, but it may
> depend on how ublk server is implemented.
> 
> In cover letter, it is mentioned that "A + 2 is a currently unsupported
> behavior", can you explain it a bit? Such as, how does ublk server
> handle the I/O error? And when/how to recover? why doesn't this way
> work?

Sorry if this was unclear - the behaviors I describe in A, B, C, 1, 2
are all referring to what is seen by the application using the ublk
block device when the ublk server crashes. There is no sense in which
the ublk server can "handle" the I/O error because during this time,
there is no ublk server and all decisions on how to handle I/O are made
by ublk_drv directly (based on configuration flags specified when the
device was created).

If the ublk server created the device with UBLK_F_USER_RECOVERY, then
when the ublk server has crashed (and not restarted yet), I/Os issued by
the application will queue/hang until the ublk server comes back and
recovers the device, because the underlying request_queue is left in a
quiesced state. So in this case, behavior A is not possible.

If the ublk server created the device without UBLK_F_USER_RECOVERY, then
when the ublk server has crashed (and not restarted yet), I/Os issued by
the application will immediately error (since in this case, ublk will
call del_gendisk).  However, when the ublk server restarts, it cannot
recover the existing ublk device - the disk has been deleted and the
ublk device is in state UBLK_S_DEV_DEAD from which recovery is not
permitted. So in this case, behavior 2 is not possible.

Hence A + 2 is impossible with the current ublk_drv implementation.
Please correct me if I missed something.

