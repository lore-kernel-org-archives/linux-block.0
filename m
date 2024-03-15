Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1F3D96E
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517208; cv=none; b=lHV1G5PeqULl/f2j1hzpYwZD7Ak3bq9jtf2t3eMWjXfpA4d3wOPF9Pnu75HQhSV4ClzWzIEAqZeKonmoy6QjgIL3IAH/dpszxktbZmJ08+duV+Bd3cnG64lm2z3jykWSNpawIs738gV1nlvJMQmm/wNCjr3sJWpb3i7UOSSyVrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517208; c=relaxed/simple;
	bh=LSs2S3iuowRG/48fRT/eg0jSeSR2vSLJ6zBJRPMIMw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uA3uB92NiekeIimaET7EqJCUvK3SbFaSk9YuciKgY0g+JmZA2fNkc8JKBBodV3UtWjF8QRH2Fs8hJY4axl5PIZHcFOBkqg+WgdklisSRN9EQ51Dgt1DfrcPwV7oT0WQtZttKKmaaWox3y8AWrncgi+CtLaimVt/Fsn0e969DpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=POIkxaCt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="POIkxaCt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dee6672526so1942425ad.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710517206; x=1711122006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKy+mz/n2AeaUmS60C/0BdHqWiGBx9scJyuqhc9AJ7w=;
        b=POIkxaCtDbSR9NK1rlTmI8XYiRLSEyRoAbMAimsoe2DLMgLRiV+kR/x4Fv0JMcenDk
         IFHZIgZOrSeNNUQPhYao3vou4CJC7miDDxfZnkkmfOfu6BApZKl/ozGsEKchZZ7saHXa
         5ZvvTpmShQ6uvigxmV3LjuJb+gbDk9cOPukIZMx4SpMDzivLxufOTc/rKaYj76wrLUoW
         dgZqb67MpgwYpp2A6F6qGYtUY/qophflbkm6IkWd2UCgB1odwreMFHFjE9Ey6pvnYKu5
         6H1httR8wvdj60zokEh6OtGZZqybG84xl8K7Ur5sDYJCYyUMrr+bde6TXm6OZu2EiV84
         ju7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517206; x=1711122006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKy+mz/n2AeaUmS60C/0BdHqWiGBx9scJyuqhc9AJ7w=;
        b=AjHIibtYJk+sQ0BYBWuZeYxWHwH7G9ViXxEsirkgcALc7EkG3EGy+pft/GVnbuQZ0t
         iBYXncveMZwG5uGqYmFxNHlvKMXmXLPkDR20wpjIHucgDXFjW5NujCNddKKYttfBFQQN
         /axCtSm6ayJRRANhInj7uDWlNsi8EVzW3vQalrgiYlDdxEt6MVtbO41SaY2bBay12S3+
         GDIbYWNrGabAZIpDrixVMhxdtzx5Jq/glXzt+GB0z40GTek2JoMBthfg/vR+YC5NiLv7
         on5VN3iSD4WMnC2YHh9c9MNGa3L9wn2J+SFSyWrVrwuJ6SED480EunHvVUXxa40vv29j
         A0Ug==
X-Gm-Message-State: AOJu0YxEHGG7tmPuruHT0XyxTfs57eURvz9uulaS51L+nmWAvMUqGo7k
	Cfwqs6kjK3fMoDOmS08A9hgbYJ6GkMvFasTrq9npxt2BjFPyfr5JxeUsU1aWk3Y=
X-Google-Smtp-Source: AGHT+IGJMgzqT5Yv4qdF0V+oJspuarS7ZOrFgxWlz1kvGziclUJc6KPFNH0hTwulRTcTH0bqmuYPpg==
X-Received: by 2002:a17:902:e84e:b0:1dc:82bc:c072 with SMTP id t14-20020a170902e84e00b001dc82bcc072mr3752707plg.1.1710517205799;
        Fri, 15 Mar 2024 08:40:05 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::129e? ([2620:10d:c090:400::5:d882])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902d10300b001ddb73e719dsm4010197plw.27.2024.03.15.08.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 08:40:05 -0700 (PDT)
Message-ID: <6d100f51-9afd-47ba-8280-51f841f9de3d@kernel.dk>
Date: Fri, 15 Mar 2024 09:40:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] io_uring: force tw ctx locking
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
 Ming Lei <ming.lei@redhat.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
 <1f7f31f4075e766343055ff0d07482992038d467.1710514702.git.asml.silence@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1f7f31f4075e766343055ff0d07482992038d467.1710514702.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 9:29 AM, Pavel Begunkov wrote:
> We can run normal task_work without locking the ctx, however we try to
> lock anyway and most handlers prefer or require it locked. It might have
> been interesting to multi-submitter ring with high contention completing
> async read/write requests via task_work, however that will still need to
> go through io_req_complete_post() and potentially take the lock for
> rsrc node putting or some other case.
> 
> In other words, it's hard to care about it, so alawys force the locking.
> The case described would also because of various io_uring caches.

This is a good idea, I've had that thought myself too. The conditional
aspect of it is annoying, and by far the most interesting use cases will
do the locking anyway.

-- 
Jens Axboe

