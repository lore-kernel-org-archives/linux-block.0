Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F613BAC6
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028368; cv=none; b=E60qSAdJJGqxH2JfcNprQl/84iM4vVu5NBUzfDmyTjXTG5ducK2ZD2ypy5nrpxG/8V2alt4V0k+Mx7C8HNgnckQuMiBaebRDKhqsX1sSAna8UP8QpajQb9/wz5sbxAxuX2genXG8+85eMD8D7JNj3uFkEjtsye9fhesQ4wefaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028368; c=relaxed/simple;
	bh=CgrY0CfBLm/Lv7oKpW3zMYd1YEIHB0kEzF3/d0trJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSXisHEmfTS8EgjW581j+XCME+nLfralFg+0NrAiV2U4sPY9HCBJuCvvMO8K8yfhrQ1HFZQuSReRzzohT+IIyyw2AZ9AyHB3z/P6ZHeKAGuTof4tBAZZcwz8nYJhlGvAf+UgWfiTSbQNYBfJfTBHFBaGzq7PxkeHQB7JBnxNCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SqaiBavG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SqaiBavG"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fad784e304so23358081fa.2
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728028364; x=1728633164; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCmr2NzFsgxtVcm+KzzvEFNxYTpPvNbNNxLvpB5hrI8=;
        b=SqaiBavGPkKEQUTMyvd+aClushIV9GGRU28ITkgBr6ymQLbOmNPUpm5EbVHh69Eo4t
         9XN/gEn/97Q3IrOuFEiaDw9nN4tFFQIgbmMuGXYXp9zPqMmjK8GO/ONXoWVJKdbiEd81
         7Zh7ioqQk1hp58Byfbsp0LPniP6jJngwHbIi3I5Mi4wkIix8Hrrqmx0Eq4BenFdPqqZG
         WRZiDiUF75tWMqvgrahZUEmyymE4Yf7QZfp38pLFPbYEbJgoaAQX5bCy45Gp5a7vOwZs
         BReu68jbCLrAiLPKanG9rEnjpsp1QII/qs2CBrIvBi0ZQP+GCPcTCPLs4m+XK0TX3mQg
         MGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028364; x=1728633164;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCmr2NzFsgxtVcm+KzzvEFNxYTpPvNbNNxLvpB5hrI8=;
        b=hNuK8ehg09mJRYHy+zExKebw7R59UmIO5dICN1yc4af37ZG8knD95JbgtyWrQBpA3u
         HTJz/rm/vkjJGRw8c6hXfiQJmVjFRyzdtKS85sjBWrxTH0EiQf5NqHMWlhDPwAEW15fh
         FPVL7jnJ5shGJ5Fooph6IymUI3Kh2HTUeULzBkS6KVtFfwU9SAJVTkXtKDfXxuGw/Tyx
         p5h0krwi53+O98Lk2yZMWUiiXG4iIL4Ioz0GXNPPkcAxE6fzERYehHKFTXRr3U095TAM
         1hilNGb0MoAVbp4CInoUWxHPT7wNyLglhDwX5lMvYELSoGXBf/fEaP/dnl3/igHSuwCu
         NCfw==
X-Forwarded-Encrypted: i=1; AJvYcCVPnCNMSLBfXOFhGhhtVFMHmOcYw4AbBmQxuWdC1dqYPwwD1QoSYVe6v+FHEQvNEUjWFaNkipbCi2Q4lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQax3SIMqKZG0biEZeLZ9rSwW/9Fae8j4pdluX1v3kmG1sg3f
	WMogl7c/lzE0QAl6700X3nmdGYMT55U+gnRf3NtIWttJFnPshRj2WSZHGEXhW5XxSdZfiabr0ZS
	a
X-Google-Smtp-Source: AGHT+IE76QOCeJJ5ofZlvzBk7neiRJtspXeFIE3aYgejhCS89B2VGNTiw1f3BSY3t9L6R7QL9AYttQ==
X-Received: by 2002:a2e:f1a:0:b0:2fa:d84a:bda1 with SMTP id 38308e7fff4ca-2faf3c1439dmr7645161fa.10.1728028363509;
        Fri, 04 Oct 2024 00:52:43 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dbc441b5sm2035252a12.0.2024.10.04.00.52.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 00:52:43 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:52:39 +0800
From: joeyli <jlee@suse.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] aoe: using wrappers instead of dev_hold/dev_put
 for tracking the references of net_device in aoeif
Message-ID: <20241004075239.GL3296@linux-l9pv.suse>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-3-jlee@suse.com>
 <bee9261e-1d8d-41d3-a600-da962aa4cf0f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee9261e-1d8d-41d3-a600-da962aa4cf0f@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Damien,

On Wed, Oct 02, 2024 at 02:37:12PM +0900, Damien Le Moal wrote:
> On 10/2/24 1:06 PM, Chun-Yi Lee wrote:
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> 
> The wrappers where introduced in patch 1 without any user. So it seems that
> this patch should be squashed together with patch 1.
>

I separated this two patches because the second one is base on another patch
'[PATCH v3] aoe: fix the potential use-after-free problem in more places'. 

Now that patch be accepted by Jens:
https://www.spinics.net/lists/kernel/msg5384787.html

According this, I will merge this patch with the 'PATCH 1' in next version.

Thanks for your review and suggestion!

Joey Lee
