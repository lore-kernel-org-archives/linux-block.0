Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4C2DECDF
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528537; cv=none; b=j+f4/FMGw/e596pZ005X9/lhtcW1OcwAnYo+KXrf5oMaGM3NMSIIngW4j3QaoUkagsOmyrYzMV4GL81t5Fb2WNZGEDbRKqMdiwgX26EOv2tX9H4rcDWRFu3Y333TVHTF9YmbdDWB5hOrWzTH/88DbXeWxUKxy8E8VWt+uSNwxTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528537; c=relaxed/simple;
	bh=XC7QW7/3qoWQsWh/RJgss55ah0drPne5ajRkBLvZJPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pr32sBa73JubSc7jIrgt+vORWcAukblm3OxNLkmJwpWc1R8fwOHGxIWjo+0lSYgXvGOf+kj4THnxJuK1T+pOhO+HEviKC2XFCWB4QWl52UI0vHhJFP6HztpY+yMWfiDLjs3zzbFQMke4upszWy2Jth98YFtkWK1qi2gptiFL5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Nz1xeiIS; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Nz1xeiIS"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-68244d317e5so1937559eaf.0
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 19:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775528535; x=1776133335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn8H+bhResNP32UDPeiU+nqzTT722Ns+CY4osAuhaqA=;
        b=Nz1xeiIS/E9IawyAWMdevCTU3aEl3AqsJoLI5UXjNlViF9D0kq0glvNx56LttKEcsw
         fg2OVDfJX7841zYbhhU3R5GKF8RwDaRnHr7wY8Rs1P8Oi6dWdSNhBtMlrXVg7g5dhIEY
         i1zKmnF2wtYVkprHsziwghsqrTyW7QPubwCO85uCCXvHnV+GMHLRXx+CDc/CNxulc8Hz
         OPjbxl5L3TS7XUuPJWz/HsWS1qRg6ZyqjyZmHaQYiKKBRrDVGG6uR0UuibL18SFeJnxZ
         YNt1UWVADFJva8SOhnS/iEtgprBYslXFLYSVAeCPPD0MUD+OzPvbHARcQEt+/BYYuWJc
         DZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775528535; x=1776133335;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wn8H+bhResNP32UDPeiU+nqzTT722Ns+CY4osAuhaqA=;
        b=R3dHMeL3TmVIJiV4b82ud7V/oOjp4HswDmPyh3ObBBzLWxA6owxcqyWNQ5kOsu+fYx
         l9m7ATOopyPff9e6O1aHSoWW3ZYACRz8R3mLoy3uUDwe3IQQ8+n10h5vaCt1/V/SGVdK
         Q8IaVJs4A1LcZaVPvPOZWdXgPSOjHABNT8Mm0hLD2/K8t1wxvLUl1EVWzLIhOjsy42D/
         nOxEvgljNn0balTxi75A0smzH++vsfXYnsGECJgXtCedY8McX2gk0Vxcg/cjASlIJWrq
         V7ihMZbJtohgnfQw4dYGchPLLJ6Smbd2kMbQfWAWgYRrNb56f9PoZ/5erGg9Lp5jAXbr
         c8lg==
X-Forwarded-Encrypted: i=1; AJvYcCWbfYrH9NlqoUK1mQVd5w23rn+Q7vtFxENdh0GtBTXb8zJMzAm1th30g9h00L9JHbGRYrv24Ttahkdk1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVyB+XbqY7Bhw9RTCSsHMPti0dmAmTglxaTeLGWnEFY6EWaoy
	4bIrHTRr7m3YPyfHjy81Oh0ZEsupJCOOAqh+6FGX2VQDF9DxhhzEWagLZJ96mVQWWmKZU0nqyKx
	jhGT+hCw=
X-Gm-Gg: AeBDiesxzwKLlU85DbsTmpkvTErk8infvdZOuUdpuRKXgGqBzJFhRFLGKmmUavLgwSw
	oz1zMJ6mRAeLR2w4lvLMLyfMQEZDl1HURKTnTzZjcmYsaLLWSQmOnarccQnASQoxBBihmWuz3b7
	5JxFPfqhor2M9wvtN2X6xYAZ19IqBYNO2QyPpu5GsH7U54YD7w+iFIhpi6X8X7ECQlt3CXGONJN
	o1qp0M0uoNpXo4cT8rawW5r7iJJ5Gnofw+AoeHTbMhz5MaVy+wCMf0hFZ33LQVAdn68YVY37hbL
	2KPxl1dMuShc0ctO1JbxmNHnM+0fG1EGkngAjgmoRNsMAK21iEXyZDO6DFhpdHKRxy5VRR+XWTn
	JCxJwxl9SB3umdd/NJMLfTt0d4PRvteE818g3Eqe88LLGciDMOzI0pQlk614AJJSqOxbBTNR7p9
	FyaLjAwZHaa6Iw2rpCmkJCz3DXe1lk98TBAyNmxKp6PrVkXa/GQ5qGb1jfZXJHkAq09wKNQC2He
	7tK
X-Received: by 2002:a05:6820:c90:b0:67b:baae:3339 with SMTP id 006d021491bc7-6821fc65f48mr8544987eaf.45.1775528535114;
        Mon, 06 Apr 2026 19:22:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-682b375bc28sm6696829eaf.9.2026.04.06.19.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 19:22:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 Johannes Berg <johannes.berg@intel.com>, Jakub Kicinski <kuba@kernel.org>
In-Reply-To: <20260403132953.2248751-1-christoph.boehmwalder@linbit.com>
References: <20260403132953.2248751-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: remove DRBD_GENLA_F_MANDATORY flag handling
Message-Id: <177552853342.149947.7297762019080456826.b4-ty@b4>
Date: Mon, 06 Apr 2026 20:22:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.1


On Fri, 03 Apr 2026 15:29:53 +0200, Christoph Böhmwalder wrote:
> DRBD used a custom mechanism to mark netlink attributes as "mandatory":
> bit 14 of nla_type was repurposed as DRBD_GENLA_F_MANDATORY. Attributes
> sent from userspace that had this bit present and that were unknown
> to the kernel would lead to an error.
> 
> Since commit ef6243acb478 ("genetlink: optionally validate strictly/dumps"),
> the generic netlink layer rejects unknown top-level attributes when
> strict validation is enabled. DRBD never opted out of strict
> validation, so unknown top-level attributes are already rejected by
> the netlink core.
> 
> [...]

Applied, thanks!

[1/1] drbd: remove DRBD_GENLA_F_MANDATORY flag handling
      commit: a9c4b1d37622ed01b75f94a4f68cf55f33153a31

Best regards,
-- 
Jens Axboe



