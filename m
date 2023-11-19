Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHwdj/4I"
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EFCC2
	for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 06:57:49 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-359c22c44d6so15123225ab.2
        for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700405869; x=1701010669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNxZEYGSdawbODTSP5FuV6b8pxNHzlA5xFxinNYLGVc=;
        b=LHwdj/4IY7K0dxubkk13wGKJDyKGQpsnjdl4bs8o3r6ikDzYQ2nq6ObIKrVcaCReF2
         gyqeYUNAbhN+VzWh/GnnnEk6Ik9nREj/cF9mxCBGF1ApHGlFP3dcvlBBi7Bd+Lr7H/TH
         WszSwKaHlDDp24+KeaizO+mAq8s+hRdoxljKHoW8zCfZutRgp4DpojTJR2jfbrSuvNxC
         y4qMh2joaVNKWWnDWvnuCMMHxYmFB0j297vFbn8WKHnfSXzIkRI6x3s8s/MF6q4qiiko
         m4DFF6VOUbUw5H4WxrOvzxdYy9vF2QlSXL6gAAXUvCAjS0QmJnI3xV0dS3W8JR+Ice33
         zg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700405869; x=1701010669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNxZEYGSdawbODTSP5FuV6b8pxNHzlA5xFxinNYLGVc=;
        b=mpzvS9SENe+RDZwn7abCvLLDdIOgoUXxdcfQg2G5udk/Y/5GReUR9CyPPwCxpSAJeB
         s9G4xg/iI1jbMgzuH8H5+Tw3dRB2ViddKJK1gHcvf8Jgth6mmcZGv/8kGn4PRUjHangS
         DUcgvn3Gz+Vyxy2/ITDE4PZrkO3z4ShraI4Lka1AJff4rJmRD1k0pv5ujkyfIw9DU44i
         JoVyIMgO2iBR7AKkNP5aJHsmRVE9lOouRYAyytLMyFaB4GPQBm1tw3fScQOevkJnNMK/
         /s9pKq2LWH9SrBxj/JDt5iPQcf5qbBBi6FX9uZVLDRK7v5XagtktK1pa4jiSAH925dkD
         kt1w==
X-Gm-Message-State: AOJu0YwicFWJxu66eA96l8es1sB9+vFajE2hyqdx3H9FtkmZN72v/d58
	0Db0sfD2zckP2V7bC6nAxDU=
X-Google-Smtp-Source: AGHT+IGmQ5CaxeSx7CsDLbDuRIlq5MkTys7Wg2O+DWYgAy+Kgo5NF3owtCL8d1eHutf5jCkvSVeb+A==
X-Received: by 2002:a92:6a08:0:b0:35a:ff35:b471 with SMTP id f8-20020a926a08000000b0035aff35b471mr1965582ilc.14.1700405868662;
        Sun, 19 Nov 2023 06:57:48 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a00178e00b006cb7bdbc3besm1165697pfg.17.2023.11.19.06.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 06:57:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 19 Nov 2023 04:57:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-cgroup: bypass blkcg_deactivate_policy after
 destroying
Message-ID: <ZVoiaucRAsPkN6FQ@slm.duckdns.org>
References: <20231117023527.3188627-1-ming.lei@redhat.com>
 <20231117023527.3188627-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117023527.3188627-4-ming.lei@redhat.com>

Hello, Ming.

On Fri, Nov 17, 2023 at 10:35:24AM +0800, Ming Lei wrote:
> blkcg_deactivate_policy() can be called after blkg_destroy_all()
> returns, and it isn't necessary since blkg_destroy_all has covered
> policy deactivation.

Does this actually affect anything? This would matter iff a policy is
deactivated for the queue between blkg_destroy_all() and the rest of the
queue destruction, right? That's a really small window against very rare
operations. The patch is already in and I'm not necessarily against the
change but I'm curious what the motivation is.

Thanks.

-- 
tejun
