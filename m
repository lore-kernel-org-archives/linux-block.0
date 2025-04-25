Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21229115D
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620078; cv=none; b=kbd4MZ/1ysiTFiYV3c13Aa5SOeGjDkq5ocmzfZ9bHBOfo3upzL3CuyBiX1PWnvu4WNGQjEWzGftPjoLvxZCcspSdCrvbcQ51EBSE0M2T/58AbEIn9eyXVOoubeN81aYEbroHj8YPjii14ngY4H/gXzGdwm3GXnK+RLs1mshx79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620078; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rysc/1dmuMZwBECJ4zkiyrx7lJ4e+/1RjWIuOUi2QUtWrcBZLF+srGZOOqDM6E5BStC41LMsfVnRmmj0PnCXGL2KpcT8mKXkg34m0UYUVqsAc96CaiHxgU/bLhyHfeyqQ65E8j3DbagX835SnxikEzjTc0ln1FaMAVdU1Xhb8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43690d4605dso20459985e9.0
        for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 15:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745620075; x=1746224875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hYWZfKy0bYV180x4t9k/o1yVtMcwqTR/riqqvL8YT9pre0ndTqZNsTuPWT2p1TV3Vf
         jyBzH08B61CJdYuONtO23GeX2lva6l3d8e4qYCOA0UVfIYJFCEzJ6R+sIqBElFb6aY1s
         kug1+TGNobDlNggjhln2udXwIc4F/u8rBnw2XU7l1UqCvC8JSf6lb/4HOOau5X+9c9fc
         gbbdUFrnGGtiREtM4PEiidQIC8ZRjwWjOz3QOxrNBv4VrjRu8bnpubFaC9+i60uJbGQt
         lyeCOlm6eQCCfzag+diP7TZ82pzXsszhvhPVAJbEiJvIPg/RmNoLRU7aN/F4Eu+76zC1
         CeNA==
X-Forwarded-Encrypted: i=1; AJvYcCUUhcOKs3bXHQ6T1E8I5V34U6Db4/s2v4TCGznG+DaKC6KZlmmaiDrPRs0IvhmxkaUxE+WnKdxOiqBzIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5j5zaGF4qFKaUwJIgwx9ioVIY9DQ+TsKfPnwSG8+6EvbZe3u
	hPUIFLnV6awxTKoZH1hYRTHyOhrn2Sv5TKdUtfZXdV6xMrYKnNTD
X-Gm-Gg: ASbGncvykSkAKDhJ/kvuubG79v5KvfRA4OVrpbMq2Qdeeu8g/tYI/xUtD5MDwOCJrwn
	G63TZItoqJ5wgQbcsf7jtD47eqY0iCn3xcdnK9zfc0Xb0KXoqWYyfSemxoOttWSFhr/Ydy+t6s4
	j7QNghKMqmnBpvFluxrIePLGjTIXNHgo5XuqP/0XeKai5sy99VWCGlY2DI0L550C1HE4/36wOOP
	U9cL3aN2TcjCgYq9I7IbUxZ15fhBvTo8n1759bXbgOniEQM1aAK40ArRGhTZgLkNcU8WK1XcmO7
	JkytNEYkuSa6bRsMmoPR9OtRt7fZVGfGfh6/Dxoz
X-Google-Smtp-Source: AGHT+IGyfiLlc5zk1m+1N6ov0KEZBCP+DRqvt49C3xYwLz0SqVP+0GOUMSfuvhF8719MVXHPYSMy7A==
X-Received: by 2002:a5d:64cd:0:b0:391:2ab1:d4b8 with SMTP id ffacd0b85a97d-3a07aa5ad8emr625023f8f.1.1745620074950;
        Fri, 25 Apr 2025 15:27:54 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cd7fsm3569868f8f.1.2025.04.25.15.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 15:27:54 -0700 (PDT)
Message-ID: <573b29ed-f9f6-4c1d-ad2e-0451f594e1ea@grimberg.me>
Date: Sat, 26 Apr 2025 01:27:53 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 3/3] nvme: rename nvme_mpath_shutdown_disk to
 nvme_mpath_remove_disk
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250425103319.1185884-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
