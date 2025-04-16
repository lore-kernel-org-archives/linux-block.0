Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AE10E9
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829144; cv=none; b=qVWQxPYxVNK06/NixlpHlRE/0PMVn8gP/IzrrR907ItrCRVDMNHRRhBNJvUlOW3z4e31XC9bb312Uqa/JvdanMZ3KogTtzSao/5cXo8ou50gRYsyOjkl7H39zsrkwvmwJ+rJidt/EL2+1XB7YIVi2z/zNSkSttOANwCdjQu2O4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829144; c=relaxed/simple;
	bh=53GG2MiIbxzhSYWwik6dmZJ/rdQgSOcOtNkFFnCtT7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWoFEaZRNcJ51NyF4UInIW2qBkjZxT1wKuZWXsHKqES6IShgX+wyuSmKFoEYHpDO8PTgkzA0EHEf39AyHqbwnvtYiv31A5XpjWPB0m4UZdj5hacV1NASKNNIRn2211vHNcnAjBj0DYASmdS+FxYlbzSMAP6BL2mnelaTap+ce2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=meGRu7H/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="meGRu7H/"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d813c1c39eso162005ab.0
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744829140; x=1745433940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgMj0jaI4A/EROK2/uYWepMSFnwXc6IaM5x92Qq/qt8=;
        b=meGRu7H/8MjjXYEpzVvbo+hO60l2Son+7NvQ+S3NozOi0+NMx9I5v+JdUsBoKuYXLu
         fGAomf/bCwibArm6CyaikQH2bEtJgQaOzZu9CT1NHNQcZaD7TM3Ac7ybbhQIaDL+kDgw
         kfEWD6ON2rcSZZxvUBfLtJHjTeyqOaAr94riro8tgxtVpnGWobMp3V1oHSBMckr7RAR3
         nXYCPQDKfsKwzwXzpWO4Khf6juZ/vV70NuWia46YOghyfyjZ6oNkkjxltNKxIua+ydw+
         YkhFInX1SzhEiHOazSAhAIv3GMUmff4eP00gUPnPv7mJvqz8ItKP/++3ptJgqYIXVS+e
         Y+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744829140; x=1745433940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgMj0jaI4A/EROK2/uYWepMSFnwXc6IaM5x92Qq/qt8=;
        b=LLqJNf6GB2lVoAANbGJB68/kj06fWvp6bpYTxKJS2rAZaX0hyKDHPvQhaa6EIIiD36
         O4CGbFpYKw7kN75PeoXcb31Vr9H50iDjWpxKwO8PWOatJEQa0W7zMwSxOMFXH8KQklR8
         cjtrVDQhzTSm37Fk26xK7Q6BRIYXOPg+y4R9KntaKZo/TajkGvquyMFCa/ziPKzNuvio
         IBxcrO3vgc/Fgsjuj51xeRv9mPhaBdJl6pjzE29VEXmxuhpsN/91y7126r2ov0+SQ6gv
         MAhTwvY65A7Dg+/uQVtPb1V4ZJTVa+WkEhfan76wY62OW48/GMF5WCzQ+1PPH2YFeWoF
         hoGw==
X-Forwarded-Encrypted: i=1; AJvYcCXxsn1QkZk+hKjPlmxkRxZVOs2yhPFvtz8sRIR4K7Z33IdqSEmIqLXHLogm8ydx403DiBOvtv6+PjpQDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiS8+/DCr7hubokKCAy5XO2P4PWSP5eNdEjNDdbw5gIFNjj4nb
	xbLerT/e2dPynEG/ggE+Wi7tJCa0/USB+jMR33Ujtp2a/2dCbK7qSavXaifqV/E=
X-Gm-Gg: ASbGncsyELJeM/yJoS+dueOmaATna2RE5u9MlBXs/22OkEWjRmdEeIS1868lev1lwQf
	rCy/h/USS8JPA+No5ELe5MrGZhAeolgYZk95sK/le/+yPv23zEuj2OtSgCCXBnl85q5THiFZib1
	jxhRxiLu/3ntpHSC9cn660EqVPkGCtlQhvvCAXwc9Kiq1N99nmbcw8jw95vZYsZ8vuGCuSI6bah
	4c6e8UHzjKG8Hxysni8CGJeajOt0Ru7CjUDlHI00/xhDyxMK+gb2dkHuHMJzqY67s08rcSOECNT
	kd8W7dvI7tPBq5ItA7Lbc7dWgF4l5i8FRsuc
X-Google-Smtp-Source: AGHT+IHPoqFa+6QBO5gg6dQn7fTrumA64P1UKltBOM6fY9VIYSB7f5Twjinjy4exriponR5vO3R7rg==
X-Received: by 2002:a05:6e02:148b:b0:3d5:df21:8481 with SMTP id e9e14a558f8ab-3d81598394fmr34636235ab.0.1744829140611;
        Wed, 16 Apr 2025 11:45:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc591f6csm39492525ab.69.2025.04.16.11.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 11:45:40 -0700 (PDT)
Message-ID: <4c922dc0-b76a-456d-9760-5cec6f12629d@kernel.dk>
Date: Wed, 16 Apr 2025 12:45:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/8] ublk: simplify & improve IO canceling
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250416035444.99569-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 9:54 PM, Ming Lei wrote:
> Hello,
> 
> Patch 1st ~ 7th simplifies & improves IO canceling when ublk server daemon
> is exiting by taking two stage canceling:
> 
> - canceling active uring_cmd from its cancel function
> 
> - move inflight requests aborting into ublk char device release handler
> 
> With this way, implementation is simplified a lot, meantime ub->mutex is
> not required before queue becomes quiesced, so forward progress is
> guaranteed.
> 
> This approach & main implementation is from Uday's patch of
> "improve detection and handling of ublk server exit".
> 
> The last patch is selftest code for showing the improvement ublk server
> exit, 30sec timeout is avoided, which depends on patchset of
> "[PATCH V2 00/13] selftests: ublk: test cleanup & add more tests"[1].
> 
> [1] https://lore.kernel.org/linux-block/20250412023035.2649275-1-ming.lei@redhat.com/T/#medbf7024e57beaf1c53e4cef6e076421463839d0
> 
> Pass both ublk kernel selftests and ublksrv 'make test T=generic'.

Looks good to me - what are we targeting with this patchset? I think
an argument could be made for 6.15, curious what you're thinking?


-- 
Jens Axboe
