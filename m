Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB04F5E3
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ghqB0x+L"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36016c6e19eso76945ab.1
        for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703608009; x=1704212809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYBuKnpQkH9S/hjSv/mU6K+URhY5X8bmBi0FAgcMnAk=;
        b=ghqB0x+LtX+vobcPERrFC8EWPgbkcOce4mJqo/6o85A/loYgUU3N+DuK71Zq08QpX1
         f9vMzNpGjKlqts+TKrqgLntvuoF1tqtIDJz3yNtL2S3maIHMxbDqop7Xdr/fS/np/C5I
         HF6f9ZTLdmBkE+dQ86fyhrGsisW130et+BYQD+MQIaXZNU3gr90eT4hSpbvrT6k5/Hle
         GswWtUmN/HUMBnkNa8reHxLAr2Br4zEsANqrmaOI/atd3MXVaWEzZEsGWzIly9CK9qsO
         omb0iRP03kgc4gqGEBaVMt9aUhJH1C3O8DBMu5Ut8b3cpL3CStZmPf5Ms/iehXa/OqOE
         vv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703608009; x=1704212809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYBuKnpQkH9S/hjSv/mU6K+URhY5X8bmBi0FAgcMnAk=;
        b=aJ0yC7hqDauEpggSCyrHj3S9rIXaIKoKiMwpiYc26rfJQ0vHU5zf95FYjxRDm4IWyB
         NpKcMcXPMB9xbQbb+yF+Avliwy3yUFB/0qBuEGMeK6hCEADhlhqtgGm4KkngrTHUUlpN
         7ECVsPYl36MFCVPuaQr53N+raWCSUdnno8AbA7G4DYyTb8tra/d2I123r+4uNv3eyEDS
         EU5j/2LSl+BX70vjPixeQi0On0eggHcy9xVS2gvxn4drZkAtUWV9GEAf+jsWw7K5l5rL
         HW1nHsuKZzjvgxsROrMKEv1fg20Yqn8PvNsJzDsdAZSJvOCT63b3Z6l+V4O+nV9U9/Fm
         fz+g==
X-Gm-Message-State: AOJu0Yx3nWObbgH09qou/eqY4OBEvgWhrZgOY53QdDpGTsMa+uaKfvcR
	7ApK6jXY6Y6FtW8teAsP2HSbH65wMGGyBHegCdS0WE/qHPfFJg==
X-Google-Smtp-Source: AGHT+IHwnpXhmw0ChFG23nvexkHwJUOxfGcMISgAlNvfCYT8lKp7pNS4KSinPftdZdYDROvo4EPixw==
X-Received: by 2002:a6b:ef0b:0:b0:7ba:86a8:fb76 with SMTP id k11-20020a6bef0b000000b007ba86a8fb76mr10710477ioh.1.1703608008842;
        Tue, 26 Dec 2023 08:26:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x6-20020a056638034600b0046b6f096e3bsm3092448jap.134.2023.12.26.08.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 08:26:47 -0800 (PST)
Message-ID: <45e78bb4-3170-42e8-9c2c-514313da7109@kernel.dk>
Date: Tue, 26 Dec 2023 09:26:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: renumber QUEUE_FLAG_HW_WC
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20231226081524.180289-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231226081524.180289-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/26/23 1:15 AM, Christoph Hellwig wrote:
> For the QUEUE_FLAG_HW_WC to actually work, it needs to have a separate
> number from QUEUE_FLAG_FUA, doh.
> 
> Fixes: ebed8639d51b ("block: don't allow enabling a cache on devices that don't support it")

Not sure where that is from? Fixed it up to:

Fixes: 43c9835b144c ("block: don't allow enabling a cache on devices that don't support it")

-- 
Jens Axboe


