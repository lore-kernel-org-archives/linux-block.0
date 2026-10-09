Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287E3C109F
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554880; cv=none; b=JKIEh7b5oZJDqvXPLrJVdgp6RCTKIbRFVkcFu8IUP9uOY+BEivxtIu4FDw59182py/rCgYNHq+aYuf89FHs3AgamBMBFqmk4F0+B65Y1Kn14uv5y3p3n0GTFfBHh3lTzWcI3jMrANmRLuyFL1yqp5Anm7uUuUCuYRA2EdkIcPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554880; c=relaxed/simple;
	bh=jeqQT3ErQIqOUqUA3FctGusMYbwaLCcKXtg5hLRbWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIcc5jRm4R5kof7tP8M/oci9JcoPVtxUKGx8ffDr0If2VP4vO9LifEKD/EHuPgWf1nwdiKI/S56p6EeR8bUX0mfQqBz4xFa5xXQX6XNRqa41ErT31I9Xfzs5sHq0xHshoNG101/f7mlOEv6OFDSUk13QO+0McHoLRR4Mtp6ecPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejyh0Koa; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejyh0Koa"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ace0741488so61909437b3.3
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554871; x=1792159671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z7MLc2O7alo1H3cSCIlZHz4ofuIV762bYU89FsiyGvM=;
        b=Ejyh0KoaDT3GQDpyZ8WpL7PxfaQMAoSclGV+tjH7VKTSKi9Xlfo47Jbk5IioxWopev
         Mwm5UZhsku0GZyO9ffiZlIc65ZUjnm1cFhPkf6UvTpcwFyGafQdCaVlyZDIYjqNXt/3i
         We3FbQoKXqzo0GauUUjr0GpO32ZYkxgv8J9JdcfNbw0AA6LwE72JB89TaBn0V6j8SFMM
         hZVl/kl3xpJcdsM4vJeQ0bqO8MyAPYmedMjGREPdmGcZsEsbI8XAx6A+TSxIcUZIbMni
         oCxuiL8FPdQTgYFzG1kVuVVBHUTYdUjg4O+ep4wRSBLZtKD4zqLQ248i6fsvmgpiTeMy
         uVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554871; x=1792159671;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7MLc2O7alo1H3cSCIlZHz4ofuIV762bYU89FsiyGvM=;
        b=bElhZNuWJjRtqOT+YxVdqj6WbVAxbcAat0SlwYDckklZM6p/BuwVx2vp9zOYel8KeQ
         edt3t8RUTVOKCeM3/R0FCCSefJG/fOZciFaIoPLOnbd5eA88u1vs8v/gBrVltik6Mu9r
         kg+b8FI3mLcLRrh65oaiMOJDeKOLBDQZ4usc2Pum7wuu3uSDrmWX9TfRG6189umULaf+
         N/zI0fObvyU8KTDDojmxqeJ77XzwaucWvKNAPklI8XynrXINzsRA/NNRSNOy4ctRmKfU
         Wqw4p9BMtzEbv5nllAdyfhjHMNnwcDIrGgayR8K/6CnyxR+e9hi1U9AtrcwZ20NBm1dT
         2w5w==
X-Forwarded-Encrypted: i=1; AKwUvBwhB9Fm7iMATOFNyWSxlx6qGlcF9OdkrVgyk9MWLAgMkaV5VXcymkTolL2rYKRG34YS7Z/2zMcNpWk3MA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKm9zYyD/oM7HPj8Z+WN9e4vZOYlQMgi1pYqbeBq7KOGAh5nFnV
	e50QC8KY1bMtIrHa9ACDwkUDDxSbSYiaHT1j5QK+zaj2uV0/zsOs5/QJ
X-Gm-Gg: AYBFou3m3rV45+C+qRqBYKhFkKqtrnDqTuKhuYfa9MSkF4ITOl6EtbNVRP1uSGPsGcG
	bxqN88CSxHGRxyC/stw7ZmbQzscGixwO9YSzO5fmHMHUQl39geGcM+OEDXTnJ80Q80XvCQQ88wY
	hkyPseUmMwULU0B6/dNzp9SyMSTMdoFxVZ0B0Tc3J/29EJKgtJpbYpOYmsr/DlG83fjvndJvH6T
	JQNSUWUbjBtvwPaVoSHKsNDFqXk8vTc7Pww/VDhVith/icg3l9BwVno+jAGQrIUSzWYayPNNKrF
	6dmVRS085RRbNLVkNxNe38kotSFaQGI7AcJAzckgkwmNGcnXKjaTOWFhQD3TaJQY1FnIkrcmHDN
	xvNDEloIRVX3bKps+RO4K7PeKapV1KL5BkHFOlERQ4tURWYB5+tS8nMagcf3TPU+Q+GKo3EEW/s
	IsLR9oV+DKu2adeWUK9HXY+KpZMpH11PGe5JKb5YkKWbGILnKTpxDc4c1pv9LDFel3bejGXHb77
	EcHokrxFKzMcyQTA4dSeJQ/5x+TQtVwDHFZixsx42TfGPhN7LhfVKP2ywVNv19y/A0bSImpTHyb
	bNc=
X-Received: by 2002:a05:690c:ec4:b0:8b0:4f12:d28a with SMTP id 00721157ae682-8b07ed9e371mr4737677b3.65.1791554871247;
        Fri, 09 Oct 2026 07:07:51 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ee83bb9sm7228667b3.2.2026.10.09.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:07:50 -0700 (PDT)
Date: Fri, 9 Oct 2026 09:07:43 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: ublk: don't keep the fault_inject
 timespec on the stack
Message-ID: <asj1Lw8osFeQ65BL@fedora-laptop>
References: <20261008-bug-ublk-selftest-fault-inject-delay-v1-0-a96af7ead06e@gmail.com>
 <20261008-bug-ublk-selftest-fault-inject-delay-v1-1-a96af7ead06e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-bug-ublk-selftest-fault-inject-delay-v1-1-a96af7ead06e@gmail.com>

On Thu, Oct 08, 2026 at 10:45:39PM +0800, Qiliang Yuan wrote:
> The fault_inject target delays each I/O with an IORING_OP_TIMEOUT, and
> generic_06 relies on the delay to kill the server while an I/O is still
> outstanding.
> 
> The timespec of the timeout is a local variable of
> ublk_fault_inject_queue_io(). The SQE only records its address, and
> io_uring reads it when the SQE is submitted, after the function has
> returned. The timeout gets whatever the stack holds by then and expires
> almost at once, so --delay_us has no effect, and generic_06 fails
> because dd completes before the server is killed.
> 
> Store the timespec in the per-device fi_opts, and split the delay into
> seconds and nanoseconds so that delays of a second or more give a valid
> timespec.
> 
> fio 4k random reads for 10 s at queue depth 1 on a fault_inject device
> with --delay_us 1000000:
> 
>                   before      after   expected
>   I/Os            446927         10         10
>   mean latency   18.3 us    1.000 s        1 s
> 
> Fixes: 81586652bb1f ("selftests: ublk: add generic_06 for covering fault inject")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks, 
Ming
