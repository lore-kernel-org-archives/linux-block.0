Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092959168
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817702; cv=none; b=AjmG4Qb8aMwAEGVACTAoQna6HqX+p+CXJjGTttQZOc2I+cuKl0JO5SawQTMUk8BeH1bdFH9wmac4oFa+v6CBClJn9NYaWf3Iwz19K8KZE7OGzR87WOHRm8IXdL0C56D3hUB8wso3gFAOtHGhal1aDSFfFViQ/iUe9L8GoRXevgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817702; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLk0Vg4Y/0TU+LMy6GL41RqnLsiaRLnDweHWpUr4x/XNHxGQDCv+VQQlPPiRII05RQnlVTE+Ac9FXtqdWKJHs3mgQSgIBwYMT/l8ssCbH0X6OFsPeXayCGbxEkEu/be0POIgPPHmkTDcCbxaz47ejUGgxF9QmTFM5eWJecVfzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee699b0552so300691fa.0
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2024 00:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817699; x=1720422499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=m2OHl/oLqabesDiGd+YpzgHqfjZrOBZDTCCx/t+Z9M1xwB+2uRW1q3ltWuiByw9TuN
         D2XtVxl2x5qIYARkeXZ/xCrx6V7Wc4WI7uNrbwXIABkiEKAg6/mLrecVpOqZD57P2Dea
         iujUTnID8FRXcds9bzzjpOCl5U8jI46nW9AF+vwF2AJNd3XVZiPPuCecq7biJEIuvxSl
         QkK0gpuZXUCP+zsNXdwzBij5tRmp0wqWhMw3enAHFXVaIkvPLZ1hpTPD30maXaeY2IZk
         WVfEt6WuOyAnA7xRyAawqGeYL9SCJfd/ZJPlVMCoaAapegkxqgRk0oz+VAjvkL44PtxM
         YeiA==
X-Forwarded-Encrypted: i=1; AJvYcCWTIw7JJm00zmk3jYRouAuaWv68C76gcKpUSRU4mS63HA6TQh7DsyButfhFXy0kpdcsDxQYs2sWmeQWQbPi1NO5+bddEp7hfe2uur0=
X-Gm-Message-State: AOJu0Ywokt8JP5rfmrFXtAL4tqVNK4TnHNepy/hgQbIE9woU8bvxoYOH
	9RH+GGlelBSySxhfvRsK2oXb59zGdtvr4MazcPbI7sHxsjgnZ8V9
X-Google-Smtp-Source: AGHT+IEgyakdEeQdj7E9cYHBzqtthbmseIELHnY1RS5Velot6nUcyAshyYc5aOvO48fGLTvo0ACEFA==
X-Received: by 2002:a05:651c:1053:b0:2ec:4399:9be1 with SMTP id 38308e7fff4ca-2ee5e2a8b15mr25854941fa.0.1719817698812;
        Mon, 01 Jul 2024 00:08:18 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55cccsm139946165e9.16.2024.07.01.00.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:08:18 -0700 (PDT)
Message-ID: <01773bb1-f470-41de-b2c7-064fec56e439@grimberg.me>
Date: Mon, 1 Jul 2024 10:08:16 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-4-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701051800.1245240-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
