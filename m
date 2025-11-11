Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9529308F14
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869772; cv=none; b=eyWhod8WpCRXHteeV0TF8YMXdWaqW+1bVzkyUtS66dMSxNEt0dk6ngKg8G3An3hXHAMkHvrcHWdzdj+6gGIub/6/rtuIUDELDar8psSGravlsQ3l7lk+DDaR2hxFvhLqzdgcaqiE76UH0hX7bSim4lMytKp7u3acJwpyLVr7xHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869772; c=relaxed/simple;
	bh=+r3MreT/sT1crw54UI3hsaeGtJviYXqN84hPams0hvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CyI9YBijpIr/aY/5kLlcS1ZQ/rnSPXxDYD4hTXpHjriWshk2zkFiHXEiTJ4oqT+7OIwzoSQz32o0+ELUssC7zrwDYynVqT0z8PdFkF1Y8gSrwEnunsUV9PW4wqH7bPaJs4tvF6iUkyphKHwzLX695Z6tSn3sMs6DnOQgfuLak9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rm1hMLqq; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rm1hMLqq"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-93e7c7c3d0bso357363439f.2
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762869769; x=1763474569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kawQyvNWLbHDUPhQUWN8vZdFV5j3qEt7ltniUTxkDo4=;
        b=rm1hMLqqj8ptfoOWC40cTuLVzu3hQBh7hJUEIgih8e4Y933cglapFvvAcxQGDg2a8B
         gt6Dn1Uk7Lwwr4k991phNHRBMgCFSaisidvxuTOdtQaraiilQn8Xzvok7hXQIzgCfxok
         NGBU7l5iZd7bcr10kEaW4ZbqRSpzwjgLEgGF6AEYl3u6lq5YCGMJ8BWpoHm4+B81Ekmc
         p80e4gLrcVECFkhlzVFcPbuiro8IfXKcLw5SRSeN44wR71vyFuhxJsYEwduSZoVRXxrr
         xshO2z4CCwlorwJ19q0N+zkBGJkF+yL83GOsC0EieAQ69Qi++eF0DsI8MnIIsFTuJBQZ
         9p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869769; x=1763474569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kawQyvNWLbHDUPhQUWN8vZdFV5j3qEt7ltniUTxkDo4=;
        b=P6MplWXxdEdK6fXJGQWHDujmit+Hp4q2qrhf651y4BNdpTiPiNfcI45HFBAYDqOq1l
         1Z9WC+KrlWYoj1fI1PsGxK6ILxhKrq3KStb74z8K8ZcGi1AmTz9+DKl9+JDYCcjlPbYy
         u45IVieg10cmeUWQEKZ/9Q7lFirWgftXlCn2RnIDHtjS7UrBByfaC/hDa6KuFLg1mutJ
         xbr+3OUyxi29V6YJO/rr6dSCtlXM5eT6XvdEoMAKjT+mgg7y20aD8NvYa+Lxomph5eMe
         wTbjkQORUAXnk6C+zrd0rMkVl1/sxMzg2ir2huiy/vA39yCtbudUehaNNIGwK8MkI2pg
         D/FA==
X-Forwarded-Encrypted: i=1; AJvYcCXdF5VFSuSLSXqkb6DIIaAtTKO8NtatVyxsRuWvLRsR/5r0QD4UNDoYFs98oYWPXN4ckPr/cTDFzjccIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJB0YhG0XuR887yZcsAQgT8HpmoDWplWlIBYUWjxZAB0Beeln+
	3M9ij4xS8O4SKKKOGem9sYcargUdiJ+3VaBHrPM+46mOmd92n8LwW9q3t5tCLLiuARA=
X-Gm-Gg: ASbGncvHktU5eJ0RvykbH3xPYxuKM1QBNaSorV9OKN1rEsFdcngw/jJbvqVCBfuS/br
	TVJtLRbyJylaHTJXC3OsKTCdx8bmXl899sraqu4QOYrymJkm+hM8OdiApcXyMp05S/L2Qjiuy6V
	0Eoxl7colqcvSBU0zqksIhB8BpGkxRBEKigSYZs5UgSF8MTyP3G7BDof5q+YyCWly6hIQ/IfFoM
	6V7jv8l+nZFaFul8dvnkGj8E28/SD4NaAYsbc6NNZKGX6+4ztfl18uqM+D5MHqKI6zvB9nB4bQG
	OlExaw3WPEBWbBxGKEYviN9Xv3G5AIZEX6z6TxJp+UuWZQL0o7b6e64PcRTxNK/mel1aKBjPy81
	ts2jpK+tr3px8GSC7qh7d+PpsNywd8LHzpaopmMQnFO+Pyseve5uN4794SJBXI0lGob9DAFYtGg
	==
X-Google-Smtp-Source: AGHT+IEjx/Ad1PPGGmmL2f+33W3x8Uw2hjSm6whM7hoISF4f4YXW/8JP7W6YocdtEbXJDFt6cPZXgg==
X-Received: by 2002:a05:6602:14c8:b0:948:6aca:4932 with SMTP id ca18e2360f4ac-94895f76778mr1714074539f.3.1762869768413;
        Tue, 11 Nov 2025 06:02:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74698c508sm6266557173.59.2025.11.11.06.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:02:47 -0800 (PST)
Message-ID: <0bfb4acf-b07d-4b12-8f4c-fc5359595d47@kernel.dk>
Date: Tue, 11 Nov 2025 07:02:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.19-20251111
To: Yu Kuai <yukuai@fnnas.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org
Cc: linan122@huawei.com, hehuiwen@kylinos.cn, xni@redhat.com,
 nichen@iscas.ac.cn, john.g.garry@oracle.com, wuguanghao3@huawei.com,
 yun.zhou@windriver.com
References: <20251111033529.2178410-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251111033529.2178410-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 8:35 PM, Yu Kuai wrote:
> Hi, Jens
> 
> Please consider pulling following changes on your for-6.19/block branch,
> this pull request contain:
> 
> - change maintainer's email address (Yu Kuai)
> - data can be lost if array is created with different lbs devices, fix
>   this problem and record lbs of the array in metadata (Li Nan)
> - fix rcu protection for md_thread (Yun Zhou)
> - fix mddev kobject lifetime regression (Xiao Ni)
> - enable atomic writes for md-linear (John Garry)
> - some cleanups (Chen Ni, Huiwen He, Wu Guanghao)

Pulled, thanks.

-- 
Jens Axboe

