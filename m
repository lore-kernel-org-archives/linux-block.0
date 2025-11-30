Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D4248893
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764543823; cv=none; b=JopWgAXWcUqqRnczUL07opjPZie5VIeT5T8AORl7LIaC/J5TgSKNyWlwoukpFya8fBMRuexfELyW5NYn7JMUahQ2PKuRnpbJ8hluRrreQUjqf07CO7zFUwwloSROfNgiGCGeB49dhnTb/VjtUOfIhSTNqvrqzbH7Z4/xvbtQHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764543823; c=relaxed/simple;
	bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6ubpOGQCBsiB4K6DO/Ns7Jq5daS3IUAXlPS7qFzap3CiOAc779seUlDNyRJGltkmqGq8GHrayi1SH6/sI+rayXLtaPB7oemax7OEhL/X5N0RkQmKA4PRNfUxF1f2Ls8GvCzMJQgJmxzhrI716EZSd8xjB1ikigrpEwCeobpEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2cf93f7dso656998f8f.1
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 15:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543820; x=1765148620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=X4zy+ravowk9P9oOHbpOGOxljFd/DvYQPuGgFfzmqCWOkOZoZ3zCCQ1jMnPSHh/tE6
         YCRCGziKCO+pI4tZQN6DqIRz4Thy76ey3JCKrxUfyC7u0mriHDrAziduf30njGjkOYFX
         So7gJYyyMQ3kA/03unLEvIUsg1AdInhxPPFOhW9D39CPLRT/Ev/mgo0V/1tnoez6Rd3/
         FwZh5iGTGqnUuyoKTPnl5eIO0E7egRwVZiGJSksi0a5J6kHrjuaM0JAX8WVEAmw1R8UM
         RtfXKw07Og3jnluwgGPR2EOnJKEa2KhSbGwPj5qRQk2HjPL8CWwa0Z/Dqdjth3Jgipjg
         W9Ug==
X-Gm-Message-State: AOJu0Yx99ISRBUEzXih2IRPdwzJA73UeHfyUusbiQhktW5GAo5lIWYPW
	kkfm0nM6KO+W7I11VIFhfKMRkYHBEMPqvF81rN0Q6bY4UBEX8OiWwk24
X-Gm-Gg: ASbGncsHOJl3v4ajfgM3xcXwiuksKcbEA+q4qIUvUbUhymLm5T8TtaVvO0yvqCV4pg1
	9rRnzNkwTLOx3zSmFqVRhR/I7HqrebOw+U74og5FnWnvhd5uO1RGSJSRl6PKptx+bedby1xT5HH
	kJ3sDappuvT1CgEonFUSeXDh2fD1P9ZjlNDKoMlGjVu6jqtlBhySjufDvZIqyLpIy3xnjeR79fx
	f1E26MWHVWZnqjgPmdKa0ML9vXMyvRE/rBXRe5u8NRYEp6AFUTM5me5rQGLg7uHtZfBncwFyV7J
	XlArxHDLBGPzp6vD7PcDv+GFw3O0q2UzrJS6kDGtqvaP5fDgbmHr6iFBZDQAPYGJhyHlzjIbwS6
	ecvzi+VeO5o05IBMXa0/hqmvkTRH5Pp/GX45wydQ3MqOweQyoXdVXRScxsGPn7fYk1k7sfXToeL
	jxSQXcR6PgzO1qLm32cMGY17r4jlo9VGUTdQYWlS0N
X-Google-Smtp-Source: AGHT+IG0kUJO7SYN4V6YpXy8uJxkqAm9wDLe/yTWTady0nKXHIsEefrNGBZg2POKGw5qhetClLnvgw==
X-Received: by 2002:a05:6000:2484:b0:42c:a449:d68c with SMTP id ffacd0b85a97d-42cc1d0cf34mr37257663f8f.30.1764543820316;
        Sun, 30 Nov 2025 15:03:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm22401721f8f.40.2025.11.30.15.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 15:03:39 -0800 (PST)
Message-ID: <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
Date: Mon, 1 Dec 2025 01:03:37 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio
 chaining
To: zhangshida <starzhangzsd@gmail.com>, Johannes.Thumshirn@wdc.com,
 hch@infradead.org, gruenba@redhat.com, ming.lei@redhat.com,
 siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangshida@kylinos.cn
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-13-zhangshida@kylinos.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251128083219.2332407-13-zhangshida@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Sagi Grimberg <sagi@grimberg.me>
