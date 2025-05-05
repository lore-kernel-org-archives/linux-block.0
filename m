Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FA20DF4
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477267; cv=none; b=SNYKJMEh3vbSsEOC3keeRQpa4OAegwCWRBvhWq47t9CSv5gAtyO2rTqZVHQUrg73lX0GJa7WmLAWEPwSe5to+8JuCkIuEsUgGDiyuAQUWnuk3a3x7mGGvgUNGP4XKVtPHTVhhKbemsZgO04vuI/r9kZuGQ61xzRaW1ctSHBAMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477267; c=relaxed/simple;
	bh=AQiFzZ+hioF3/4ec4StyGYUiDu4auMssToRPssmrwCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifobu1oww+YHHRp1YZoOvQr61d/Sh/uraJej4HE+Hra+iHxFNgZIVwhhpSZtLgq2otFc/qufpp9NYZUHDu4Vecn04E1N9tIYX7QBoyJI3g8qJOZRlr2rW+uIIpkqIu12fQ6R9bSKcJmBkV+az7E+hvVrooggF4Nb6F+38IsLRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RXfuiU2B; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RXfuiU2B"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6f0ad744811so40090336d6.1
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746477265; x=1747082065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjt5SetEQVeK+FSr50cmz95zo5QuMyYcarl0Ii5W2m4=;
        b=RXfuiU2BCnC37wgciCr7iHmhUKd6bP4+1IFDfwyTw66vCVCCqbZEao0yy1xaZwthmI
         27v6GVqW7vj1EJ8hFCc7gai1I5tWu881PtmUD7UkE7R8gHFLRXnaMWLkQMYvL/t+RmZE
         J+ikBAmPthXN87sVI5JouelGD9TrrZO3r1l88CcNMFJ3mXS8hK3lF4ZarGaXys1n5tgQ
         0a+JTX6Uqq3oAdaJk5yHY4hUJImQ9d2JNGc2fi0YqGNshlnNHu2KvkSnPkyX2bMPCDEN
         +ie59/N60uz9kSKpCY9wrJxV2ZTUaXlL78P6pTIszkGfXil7KRw8wSiuj0Ivb4B9ZXpa
         1bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746477265; x=1747082065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjt5SetEQVeK+FSr50cmz95zo5QuMyYcarl0Ii5W2m4=;
        b=jBEBg9v0SQQ06/FRZ2SJGrR7CLzXcXkmkrDU+CsYfOWqCfaJUgrrufxrK5cLuBYd3L
         mMUDbE+KH9e8u6A3zhP0IE8QCzMZKIstRQao6U7RuZJ8LGn01m0pWUuHiPidJjsnyqyA
         P3DxOhrXbAwkafWMWVXdq49qXWpuOSYwQHjlvFP1qJR46MO3LPJ7eloaxx1mTzAsazv+
         Aluj8HNgl34EpKAGI7tyh/7N1tYTPSEGtRy8pdtgiVy2iHPSNxZpWKKM6pfPBLAeWuZ6
         cJ53JlV5CkvDmbvRdg5sK3DSPMkXzLKZj0elnhV6S0qbw8d4YGkJQ9kDZQm+uSfMiKxx
         2k0Q==
X-Gm-Message-State: AOJu0YyXOqItggF4fasltD/x5Ke0Bc3qhDlWyb+F8zT9ECnTrmgqrRik
	t8jstqoRUhbClZjzMEkVaNiM7qwBe7dQIVyewLXx/65nRRN2U/6v8MaBupsRFMlszNVq/bkDbev
	dfu/jDVz/BjxaBiXSbAJVcPJhTzm1S54/
X-Gm-Gg: ASbGnctRfIxVN0lqi9XrUhDFHoVYJIG9GVE+kEalxmY8Pq4EzPjr0DQRS3M+YbLWnLF
	KVR4gQTmDZHIYSPiWgWGvAzCcAnwduCb0coEfyF6tuIN8eMMMsm5ybOeaUBQh/Dnp84HstEwzq2
	ZbmY1ZkJMLptmXFS9deaG/DkfJp2dGMXQS4KLvGZUugBI+uQ1lU4QKMvPUY85b8EgvpN5Ht9OQy
	zRYOumiiL0qA7qNH/N/oRJ+ZIJkNBEZPS3+1hJvpRMnyzYH4uCYiMljazYAhCVicN9pd/s03FvL
	5zN9B1zC+2Y3WvY7e8YB2hQN/C6cwf+wX2WBHdgD0cNDWA==
X-Google-Smtp-Source: AGHT+IHDhruxKjn2niV28wBPJpKZJOMbtoa+Ime0L962AGQ61i+87oKEyyTGXvRQxnnGlsuLIRHOP/l8m+Wf
X-Received: by 2002:ad4:5c8a:0:b0:6f2:c81f:9ef9 with SMTP id 6a1803df08f44-6f528cf8e94mr138201146d6.33.1746477265123;
        Mon, 05 May 2025 13:34:25 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f50f3c3363sm22898456d6.27.2025.05.05.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 13:34:25 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5D95A3401B7;
	Mon,  5 May 2025 14:34:24 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 52ACCE401BF; Mon,  5 May 2025 14:34:24 -0600 (MDT)
Date: Mon, 5 May 2025 14:34:24 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
Message-ID: <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>

On Mon, May 05, 2025 at 02:31:40PM -0600, Uday Shankar wrote:
> Hi Jens,
> 
> Can you take a look at Ming's comment on the first patch and merge the
> set if things look good? I can rebase/repost it as needed.

Bleh, sorry, I meant to send this as a reply to v2:

https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com/

