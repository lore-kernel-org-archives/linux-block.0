Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302FA179BF
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280426; cv=none; b=eX8C6M0kRGP220zkZEF0UZNFpgJmr/VrwaAbItpcT8yV2qs2WlXTsturmYi9MmZkylDz5jH3OP9Scfi8FjP0di8bouE22/KHaLtdyjDcXANKm4MxCHKimWeeWShRuhK8yRLHi7X/ylWCOXO0J7orfjQTe3rMeP7lMp35GljeetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280426; c=relaxed/simple;
	bh=2/ItSGvF6rGgeG3h4/lB3OqIzyHXZOMXUepazvJmATk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzwpBb1EV+zEFL2oXYI3wyaSF8QP0SKQ83CTb4B55A8/iRPom59a2w48D87lKYevp8r++iBpr67Z//eZMXxtTDSxmAIwvSMC0Nb6x7n8ACbsLpFxnnpJ6xWgEbBARLssT7ikhrklt8EPlwYOf4agkjlPsEhwRFvP3F9AFTgs2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gDdCtND6; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gDdCtND6"
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3d813c1c39eso36613515ab.0
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745280423; x=1745885223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRHQSpe3hqbzzlGSPCYIDW5/Bxa/tRsBk1EAkp7TzNw=;
        b=gDdCtND63oxXd3d8IjgnhaC7khnilbdyP4/KHVwYnljEkuMoSdQAmJ8/m7vKq0DSit
         YM6gMgtATCz30186A/tQ8dFRxFimnh/C6I0hzFp7C54qPUgzGBAfnas5YG6XmAPepQu3
         h10fageH7hgyAHV5okdPnp3sagOCFCGL7H8dQ9zd62uRzqZ/WLyVlYjM+2WDC9+IpSlt
         /yLG69NHYTyQIKP0kK9vn+mo04hujJKhecQSS/jyItRl3GZtODMO74+6PbnYIlTTFzg4
         NwxJ6GkeE7DvIcHDfU2hoyBylwmQwUdsT3jSYYpBD9hnVituL/sTgxRFiUA2mXGfRlEl
         OdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745280423; x=1745885223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRHQSpe3hqbzzlGSPCYIDW5/Bxa/tRsBk1EAkp7TzNw=;
        b=giExGyYnZ2nzBKfPbIhs0CaXg86T3MiogwOdwlBi7au8Ih4jEPOHKUiOS0gTn7dB4F
         0+CEmMaA4rnOlS6F7y+lsIq/EqXoyG+cpp+6LzK4/vFdgJEmaOQF6PQBNp0PBKLcJony
         TK+ef6Nr+BJM9NKiqzSlbMcvI3Nm3CDwQ0zkCplxpAhCu9NaUxg3GpzeIG8Ni3plH55M
         c1Njn/fAoTZfI8tEhBl9xpZagE828Jf3Dw/ZciaxNt8pVMVQL/niefn9akIyOziaEy9U
         CKTvQ6XAkczMWpPbKZdVywyOIyAgRGjIFPVCfBQ/GmhFOvwppgaliwxrH4P0V4qz7mdc
         NSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE02Nnk0u5R2nARI+F4A3VwBFaIWpq5PDC4xqAaZwpCg2oTLlWA9DkH+WEACYlLSe7+Q00qJKyKJN4Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UbJQN/AK6kYNAF5wOVLzprwyiNNjiruxmWPyB1/O11MhDL8U
	xiFxq4SkrX4pJKuc4iwbGR/tfN9+BiS4LVGEtEh5AoawHIzRkGCtE+8/1eRwxs0hvOsBwORUna9
	/522qr43BS+vksmJRXA54R5SEwi1YILVHgFz8Jko4UQbYkwuP
X-Gm-Gg: ASbGncvF7sbY5+JGi69sIbqHco08tsPPNnQkWEvhILryKDjZysbfO1MHJ81cWf8TkPS
	IE/3zJhAgpZazrQ6zeP4EO731z2piWpQi4bU9J+nzMqzJNCtQuTm+9zYY0b8tk63Qz5nDwG/eTH
	FXwe16a2ZSuNEwL/NqF4Sn4A9G1pe1K64wJyhBnL01k7aXW76SjXo+AgjxMAytvoN9WktZuQZMJ
	NV2H+vRkCfVoCUkXDObnKia+UFjpdEJYnPHhHlMdf3Nz7Kq8FEi0TizbcMenD13xx1t4DXAXS8l
	SDvfPaYaY6biN2lQj578G9AojNpT3ug=
X-Google-Smtp-Source: AGHT+IEFZYyvSiZOdapNUHDfETNPMM02yrCwc/5zVASK4p1+/tuD6HhgTrgnpoGuOSoDxHy/YWBduoqDV0md
X-Received: by 2002:a05:6e02:1fcd:b0:3d8:1d7c:e199 with SMTP id e9e14a558f8ab-3d88ed95ac1mr150939385ab.7.1745280423166;
        Mon, 21 Apr 2025 17:07:03 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f6a393aba9sm307386173.54.2025.04.21.17.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 17:07:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 020713403C6;
	Mon, 21 Apr 2025 18:07:02 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E599EE401A1; Mon, 21 Apr 2025 18:07:00 -0600 (MDT)
Date: Mon, 21 Apr 2025 18:07:00 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6.15 1/2] selftests: ublk: fix recover test
Message-ID: <aAbdpNWSq2bl6L5u@dev-ushankar.dev.purestorage.com>
References: <20250421235947.715272-1-ming.lei@redhat.com>
 <20250421235947.715272-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421235947.715272-2-ming.lei@redhat.com>

On Tue, Apr 22, 2025 at 07:59:41AM +0800, Ming Lei wrote:
> When adding recovery test:
> 
> - 'break' is missed for handling '-g' argument
> 
> - test name of test_generic_05.sh is wrong
> 
> So fix the two.
> 
> Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  tools/testing/selftests/ublk/kublk.c            | 1 +
>  tools/testing/selftests/ublk/test_generic_05.sh | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 759f06637146..e57a1486bb48 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1354,6 +1354,7 @@ int main(int argc, char *argv[])
>  			value = strtol(optarg, NULL, 10);
>  			if (value)
>  				ctx.flags |= UBLK_F_NEED_GET_DATA;
> +			break;
>  		case 0:
>  			if (!strcmp(longopts[option_idx].name, "debug_mask"))
>  				ublk_dbg_mask = strtol(optarg, NULL, 16);
> diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_generic_05.sh
> index 714630b4b329..3bb00a347402 100755
> --- a/tools/testing/selftests/ublk/test_generic_05.sh
> +++ b/tools/testing/selftests/ublk/test_generic_05.sh
> @@ -3,7 +3,7 @@
>  
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>  
> -TID="generic_04"
> +TID="generic_05"
>  ERR_CODE=0
>  
>  ublk_run_recover_test()
> -- 
> 2.47.0
> 
