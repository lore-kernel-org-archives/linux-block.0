Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E9632;
	Fri, 31 Jan 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310962; cv=none; b=SsfkHozPUm/k3qYeQAnJEQWaBKcszi0W9h4J8z9UgUopSSaGLEuM20zjI7KXTB1v/eytk+lX9KKfS/4/VwM8IKl5nNHWrspz/p5KRiVxmuRhJpIeWnAcWq9chF4uqvKQ4ZRfX2lFTLV6G+d9VlnaogDhGXidTWqFuPnQtDJSg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310962; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ7Pd++mjoE4FCat20k7/2eDrozOLUxXixXzxoywteSa3+msMR9PLu934cOmNvCtLXGePaOag8sPo6WfSRRyOCyg4d/NkUazayxz39mGkiFaqNNymNIhI3FYgqYkzdqzbu0QYC3D1hkexcvKa4rkuqs0bcsAzcootX1C81cmbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso17170695e9.0;
        Fri, 31 Jan 2025 00:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738310959; x=1738915759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AMeTf5CE7kxB3mm+7SdGY0O6u1otchhMBSKnqIsPk1YbeQOYA7V9P6bacOH1zUv2Xf
         ksyAjQOoRnA0jTG0HXCSsvOee/2Je41PkqsB1TIpL3ru7u3Abrzy0fwgVBhuoe70reFl
         26rFjvKrrQOqimuJJis8Pj4pwZY3VhTW/vEYcon07E4FRJl2CvJLzNCTgTcnXpEjw9M4
         isgkhZDy70sxlwNeDXbKxuWeQunVFb2vsjkmdloXWO1+MYBjCxfbJJw5TjfLaJgTRl3u
         5d6e8qf6Zu39tp+UESSXA8WPhI+egtdkTs+W19vwqWlvnlXOOzaikSeX8qZH2m3SJxFj
         pUTA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Z0+u8heSCBHvscABN+5O9xNeXGMv6gS3HIr/Z4wmzJidv1UFOJRYNi1Qdw31wyPLREbsMv2ZdggepQ==@vger.kernel.org, AJvYcCW9zsFb5juqcs5ND0sUqoqSoP+eidJaDPH5SKkhqGC1x88WZJqVq4SlT6aETfAxDaPYL7XwNY15ADL6Vpia@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiq3QYsTjbUjuHrGPtQSNJ+rgNQtnzod+4dWrSxg/h5SSj/7mp
	gh8pJLYIw4Cfa0Z8utTs7hdxfkAfs+6qaufRP29ZV3z5OlxtgX6EuHrNFw==
X-Gm-Gg: ASbGncsnSsnrQU/h+e9QxHNxkqnxe8xfcuICDA3cQEfcStM/egfLVAQY9+XM9eUEJ/0
	uZW18JlI2mJGZthw19qis6wekYrLJdN54jNVmTXkwvvxs3KSsmbKi0OE0rGXbLxAfS/Ng75suSp
	Pp7nS5yzbGX5g42SP2UK995e3rTiAfOyn5TxA3+4I1EuRNMnB3lYNiFlbAQGC3NKLioxNGzE/rZ
	1iEOTKaeze0vCO2YE5BsAa3XEWgBKzQERrG2zQrkWjMZlRv3lF41BH8MMflIOiGRho6kI7YjHYv
	PopTrdkyXnKq8AshHG5raxjnH2X1mmRDWCTQtl0F14BtwpJOjGo=
X-Google-Smtp-Source: AGHT+IFRd1COH4ffU5+pBFd8kF8BxvX8bD09TPD6Kz91rUI+X5t5CDX983eL/O/SGdvAqyh5EOSmQg==
X-Received: by 2002:a05:600c:3b9f:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-438dc3caa6cmr99103495e9.16.1738310958584;
        Fri, 31 Jan 2025 00:09:18 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2f73asm83240585e9.24.2025.01.31.00.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:09:18 -0800 (PST)
Message-ID: <f8f17b22-9d1d-4929-8eda-d0c2a679dae0@grimberg.me>
Date: Fri, 31 Jan 2025 10:09:16 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
