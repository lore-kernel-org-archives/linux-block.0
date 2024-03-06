Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66CD13BAE7
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739338; cv=none; b=u6t3F8seDg5dqZ3t9AYGaWFjIqKRxIi96JCZq/WDAEn8iO3qQEV0KOnfGgPxyArEQEePC1o3VqVYNSBMZuQ5XD4buIghyUbh3mnlMo8VUlJkYjxGTsaeQF7/k/nhDAOb4An3cjufLwT8A98Z2RZ5c1UcKE6oIHrcueyeJOGlcPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739338; c=relaxed/simple;
	bh=VBft5w8jsJHzEyBJ6P97EckERupZPHmyvdDoIbCDjQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AvIvXnGiDLwXUVBpFpDaQ6RYlz8a2iqwYi23g7Uj+1RtETFhT0tXvieLW9ErUrE5yarQWmz6ABRdZF5/LAjY2SWn0ivJcVydNmMAYnUCvTZbmNYlXsjYu/lOCmIYI6eL8vO49hQoYhRXMJQyNqu0VlEtMnT2H4jnhjWN3+W0r0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d8Fpz0Zy; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d8Fpz0Zy"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c495be1924so67153739f.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739336; x=1710344136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSixkOvyAGzPmQR/w8/wd4aDROkCteYD9fEs3nqiTTc=;
        b=d8Fpz0Zy0b6wygN1q8Kl0tL/bmsMH2o4jySgbenFTg+/BwcRrSMoe47vJt8OP5PsOp
         zSh5D96plXFBKplFMAPEXk9LpLGsQtan/9KauT9vWCQAHNZZoi+s8Ez3mMShwhUff/Ws
         tASrgdWTTtBNO1l30UyAnn5dxXlIGn+o3HHfCnoaKoHT3X/cuTifh8npP32vmTV9Rxlw
         Xg3B0sg137IUpqR3N10o0UfDCuTH1BEk7UFjqtUkwAiZDwGTQLqpQCD1VO4UAsJQqeBP
         0gU1YuvXhHqNgX41y+Yb5kEBFsGDnMG47hje6o1dFWFI2ACEQxRsHNRg+HsdX+rxk7YG
         u6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739336; x=1710344136;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSixkOvyAGzPmQR/w8/wd4aDROkCteYD9fEs3nqiTTc=;
        b=Jz74WgIA8Ltc2A4TUy7fObg/Xxsw7GEYgRY6t/hVUazrzvr1Z3Rrzx1BtzCmJB9jJl
         qlIjm/T6smab/NfNGynbFRQUk+M0TEHmpKk7KC43POkZeEtj8G8EYPlnU46R9W4/9YBg
         VCFDjtepF3O1DXOEsPDovN52/i21MpnETKEGA68vU8o/PQnXdolrxjbMhTZi4K6tklPT
         thrIuspTmLpx1EHlwXJM3xQ+UfaCHnKviIONWdJAZGjaV2OqgdsZuJbU288nU9vjY/zm
         qPLE4lRmxvKSHohO6BALBy7W3B/y0q5YzQ0CQNIalygxZ0IBfYyXsI9Puz47TARaA1hA
         FrJA==
X-Forwarded-Encrypted: i=1; AJvYcCWOQSD2xhflg16RHbb30gUh2ON8C1ubcBQvuxlAv5Xd6xJ7Gz+q/7VUe/EveFs8vlw7vpSsRXMmuUoEmdrg3HK6whj9OFJjP/4Y9VU=
X-Gm-Message-State: AOJu0YyoWRuQykpBXJscPmF2Cq5okMEw+N5XuVLg5vxOAFowRnaJUg7m
	xZFzxW97WLRgeKB1OPdobvrxa0+DlIB8uI2uiNfuCbGAyAVzi2bKT80rsmBfOLo=
X-Google-Smtp-Source: AGHT+IFSaGBg8sH10us0bskBsK7ms5bsiWhwU8fuVwlEdJVXM3oZMPq6CZjM3bs2N5+keLV24lzbqg==
X-Received: by 2002:a05:6e02:1c46:b0:365:fe09:6431 with SMTP id d6-20020a056e021c4600b00365fe096431mr3733400ilg.3.1709739335996;
        Wed, 06 Mar 2024 07:35:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Justin Sanders <justin@coraid.com>, 
 "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>, 
 "David S . Miller" <davem@davemloft.net>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>
In-Reply-To: <20240305082048.25526-1-jlee@suse.com>
References: <20240305082048.25526-1-jlee@suse.com>
Subject: Re: (subset) [PATCH] aoe: fix the potential use-after-free problem
 in aoecmd_cfg_pkts
Message-Id: <170973933432.23995.8994501180418490235.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 05 Mar 2024 16:20:48 +0800, Lee, Chun-Yi wrote:
> This patch is against CVE-2023-6270. The description of cve is:
> 
>   A flaw was found in the ATA over Ethernet (AoE) driver in the Linux
>   kernel. The aoecmd_cfg_pkts() function improperly updates the refcnt on
>   `struct net_device`, and a use-after-free can be triggered by racing
>   between the free on the struct and the access through the `skbtxq`
>   global queue. This could lead to a denial of service condition or
>   potential code execution.
> 
> [...]

Applied, thanks!

[1/1] aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
      commit: f98364e926626c678fb4b9004b75cacf92ff0662

Best regards,
-- 
Jens Axboe



