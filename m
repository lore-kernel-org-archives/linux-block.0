Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E674A59
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257766; cv=none; b=q043pZSQBinpyUcOG0B3isYDo14v3Ly1vKzOr0SWsUTxxXnqUnZ6RWSEyvQ1R6mtdWu92klMbXTP2UVTBFoTbf9zcmPOxbF6n3iweGq5PgqpHtBUsv2O4C3Yu6d2haiiIgm18nui6sebPmFGaaihR+H77MWPIe6SOkUhhlQvxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257766; c=relaxed/simple;
	bh=KVSm5h53JjFStKY2gvnPj7UGTsSalTHjkbAkyR2CxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsdzbVClRTMfPU6gnfZxNUOP6o00+v55s/dDr89B2zzEnJcYyKprXHuJ/9Fh3L0Ly2XzcgA5ig39NzMdmE1QkeHfItUK8871f8a3DIXYver/PdKCsYH5lR75nFBtfYdMiymypgarCnqFl5B3LI7TuxPFbipJwHM2NhAIkkRowLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=XDZ1eMpT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="XDZ1eMpT"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b45edf2303so5699503f8f.2
        for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1753257762; x=1753862562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4FGQDICoj709niCH1JdletwVMfvxWAdBeLkowLzFOU=;
        b=XDZ1eMpTTCk96gFsfE5zgrw8sPEby/pRiqhNcjoqlgHZNTMdIIJor8ZF/Psk2VRyie
         x7Qz6OHruYsCrXVZcdAJD0piIqn8yAbO3tyMcX8qChbJH2Q8iDstw3jrr8jWS4C+a9WP
         Sc1C5Ebt7AzfweQtp75NjTGsfgIexa80YB2Vv3onXS3nVZobvIkphcXjWuskUSiNtVfX
         gS8GftLtFQiJLWHCyKGZ2EKNqqcrTOWTlpv8TzPar/NYxKUoEgOVdGsYaom0G9K23gOq
         ycYYb//bN/EReiW3p4k0tqwOsWlgZlYvM4nDNLzFCFdPvHlHxpNpgISNg9WwdDzSuUP6
         PHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753257762; x=1753862562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4FGQDICoj709niCH1JdletwVMfvxWAdBeLkowLzFOU=;
        b=dAcvtUjyujFm4x/6pADiqYN8J9H5zvicA0jmSIouNV2cIaZtzkjDDpEZaIYKtKH59G
         t6nTjTBByI7298ooapC1PTR+mEQspjHhsHsiR9t3HCkn0A2HiiRDGbugKDXzfkzEfbk7
         htDuaVuh5fFyJG2PXMh+fYF/eT1jptlBwkZ+uX91kxq2UNbc4x2K85UrySsH3tZuDkSn
         aHY1wJ59vKyrOgByp0ON+q5E64M28LqKPEqNjDX7R6wNHF8qnlO4IhTiQzCvu4kqRUPi
         k0l6cje+fmTgiRRZaqtUHnqfAjWGntOa5b98A4QsDLw9MD2Vm/np7AmxcxsoKUSrWGjV
         162A==
X-Forwarded-Encrypted: i=1; AJvYcCXY/UTM3le8AS4dIKWKsj10Pp7LScA8dkwU3R3Mb9qGuSgctde06GnUUl0VZFO1cbYXwJgn/Utd1L2Txg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJg0hk/nFRJG6DHDrB87lCVhk7sVakEYRAyYVhoRHRZIMmJg3
	Z47IOpCA4Xe2wUPVe7/OQ0EOfT+yfG6d0/EqRIjdUAZqnhMdacvPk5Umu4oR1XpcFAU=
X-Gm-Gg: ASbGncsmuzXspG+F51vGrHKq5TU1OK7n9aUdeFbGKR7SuJyfmJAxoECWprQzndPP8SA
	q1DgG4V5nq4sTg8PumCwSG82xECT0/ujLEwnev17+ti90D/ne+kYnd0NYpay52W80CVi2DIy7vt
	FXz6Wl+XRCFT61WDgl5NYa9YF++mUAnU4dT/D0zNljxULcxDmXk8YuYFtQtW1hsAPgNvu4/W2vB
	iWQnQ2bBcDYY0FsBukWF0K7rAH9MNZktAm4sQZlebY5XF73XwSP72U9Oyc2lXtSbk3Uii7oLTX4
	uMI6uQDvV42En+kkrb0gdfC2qxJ59IRGjX0/OuSgBpyhXpqcl2SZlluRkBK38lSdCBBVuwLPYkO
	OtMTiVPICW61Xn6kBXdEi+96Z44QuU3rGZV4fLgXRPiPb93Kd3kCMMR6QT4L1dlqk96145PN+y8
	6rKhtB
X-Google-Smtp-Source: AGHT+IEOj1a41XbAbtsyn9BZyYvJGFxbKtJMrrE3O6MQhzP3R5l+6zTyvBefXb/flvN5X0mXn+BarA==
X-Received: by 2002:a5d:588c:0:b0:3b7:664a:8416 with SMTP id ffacd0b85a97d-3b768ec1dc2mr1555586f8f.23.1753257762048;
        Wed, 23 Jul 2025 01:02:42 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45862cf0fcbsm37997985e9.0.2025.07.23.01.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:02:41 -0700 (PDT)
Date: Wed, 23 Jul 2025 09:02:40 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Phillip Potter <phil@philpotter.co.uk>, axboe@kernel.dk,
	senozhatsky@chromium.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-ID: <aICXICNEcwutw9C4@equinox>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
 <eyejjkuzdzl7qlq3os534ckt3jsvvnvp76pyqcrpzcignj3oms@w7cvw6oht5lk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eyejjkuzdzl7qlq3os534ckt3jsvvnvp76pyqcrpzcignj3oms@w7cvw6oht5lk>

On Wed, Jul 23, 2025 at 10:14:32AM +0900, Sergey Senozhatsky wrote:
> On (25/07/23 00:18), Phillip Potter wrote:
> > [..] I plan to do more digging regarding this, hopefully
> > this weekend when I have some free time, as I'd really love to replicate
> > the original crash.
> 
> I waiting for LG GP65NB60 shipment (arriving today/tomorrow), which
> shows up in crash reports (it should have CDC_MRW_W.)  So I'll be able
> to run some tests soon.

Had to fake it with mine by forcing open the relevant code path for the
check to be done. It still didn't crash, so I'll be interested to see
your results. Will hopefully have a dig myself at the weekend :-)

Regards,
Phil
