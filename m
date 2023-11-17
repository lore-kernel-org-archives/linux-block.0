Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OxyhHjOL"
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147CF129
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 17:33:14 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1e993765c1bso804384fac.3
        for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700184793; x=1700789593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3/SF+yftWZN9c10ze6QSH+tTX6ZeykKVwwSajj3czY=;
        b=OxyhHjOLvz3areOZulLrsfpqHzzipLHL+x06KQrYL80GV8ownUAqnDptru2bL6vyVk
         MSja4klSoO0ynr1DlhR1n/yuJ5/lZPysUkxVQZVD0vnpUEtKxqMtcGPw/YBiFKaLq+W2
         LQz1l2bPiM+SCPeokj9OIyMVWAQ0V9Sb8r5D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700184793; x=1700789593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3/SF+yftWZN9c10ze6QSH+tTX6ZeykKVwwSajj3czY=;
        b=lBzZrRCR1O1DAi1Qtv3jMqw4jkZCxPrVKNX6H32AkQAylN7k+Vb+JOhptWWfQYyK+T
         0C0fxICz+rYKLCpPzP+ZrXtvTpJ+HqmgVNHmZweZvmq+GBQtWU8llyfxyp78YFeblETX
         nSwLGBajVmSvy68orpNZXq6E9n7jHjKgMXXHOoivwaQB2dmTMWSzu7z9QA3X/13Te7xr
         2EslMvHGXQsNtUqbdNhsMRAGwCI1yyvCeMPPeXqw4mvPSHivrNoOcqJRFeXO0AmBPjkZ
         O1xPkgmn9RodYGZg1S53t8dnky09zpsNWvW9mTHwBYKIJA7/KhQ4E4w5T6AjtsL4ls73
         0I2Q==
X-Gm-Message-State: AOJu0YxQ/ZaA7ISK2Q7j+/opCzZIo2DfmI7hGCyMNuDTjqlifAkvfH1e
	bp+v1tdpuwJylSflcYtLxL7/H4eEWF7yjFgXZjk=
X-Google-Smtp-Source: AGHT+IGpukM03s9xx0sloWta4DzmNJVY5za9hvMSwCyD6svZ3/SdrG08z7sPsMLeT4HO3Wo1/OkUlQ==
X-Received: by 2002:a05:6871:4308:b0:1f0:edce:184c with SMTP id lu8-20020a056871430800b001f0edce184cmr23859443oab.54.1700184793422;
        Thu, 16 Nov 2023 17:33:13 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id f2-20020a056a0022c200b0064fd4a6b306sm367435pfj.76.2023.11.16.17.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 17:33:12 -0800 (PST)
Date: Fri, 17 Nov 2023 10:33:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: split memory-tracking and ac-time tracking
Message-ID: <20231117013308.GA1325348@google.com>
References: <20231115024223.4133148-1-senozhatsky@chromium.org>
 <e8fc0801-359a-495d-bad5-c550105ddfa1@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fc0801-359a-495d-bad5-c550105ddfa1@chromium.org>

On (23/11/16 15:27), Dmytro Maluka wrote:
> On 11/15/23 03:42, Sergey Senozhatsky wrote:
> > @@ -293,8 +301,9 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
> >  		zram_slot_lock(zram, index);
> >  		if (zram_allocated(zram, index) &&
> >  				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> > -#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> > -			is_idle = !cutoff || ktime_after(cutoff, zram->table[index].ac_time);
> > +#ifdef ZRAM_TRACK_ENTRY_ACTIME
> 
> CONFIG_ZRAM_TRACK_ENTRY_ACTIME?

Thanks for spotting this.
