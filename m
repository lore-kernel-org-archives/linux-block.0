Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E516132F;
	Fri, 31 Jan 2025 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310981; cv=none; b=kai+bOo9J+qfGaucqdwH2CdZL1PnEpxCauUqEUXDpgykQsyFV5BVa7Mi7CpqOLyJEaVaW6K5kTeL2XFAmLOZsKsn63Esspofcpho++DV4RFdzncEYrpaAOk+I+Hny941IMdNpbYUdfqrG/8/fv1cO/vSGqtabu2/g63S/yx1K5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310981; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQm9iaYkQ5io8YW0mJS2yVTzmEoiDYGHBVm3KFtx3BJRePRhkNxHOVOG1Mg0N5IAbUCSCvl7NZbbiQcIORMCyKRjiUo3NB1VUvA6yiGHmmrUl5aldKx5OxFFEjxDmcx9kncjGXgZPxq8oV0Qja1CYckrqtP7BFBtVAmkzdRDlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso10156225e9.1;
        Fri, 31 Jan 2025 00:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738310978; x=1738915778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rJA+LFi3JDWdGP6Lp+yHJnbB7o/xm88yXadc89e8ySzA7HS+4/XgmSd56IS9FJYd7L
         N6MrYFN2e/hHZ5saEOVfcMuSwsLUDoTmxyYE8r6puqbQE0l3HzvhVr4ldKstOXmBmqyA
         Hz7VmLNd03cALnFq/DvoMoh7LeFjCTr3DgHDUZzLnPbgLWx31Z4gex/1malAHBhBu7Uy
         LPjrDRIr9uXByqxrc/06Zv+fWKySQS+f8N9pzSQQY89c/H2fPb52KoIiRIrpmwWofxYK
         dha9FEdnaDiVtKB5ZaOr1uNV4LyL9raTVguuCSjYVfAaC63kBfpl9WjKNAK7tevii4hg
         RwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAbKaxsH0rV7Y3jRzYj5VuJ0a/JiDhZnDulN5tc6UuJ5/iJaYLteMMyQWw/8mB8xyuh+zlazYY/gLAXQ==@vger.kernel.org, AJvYcCXhuDZvwtlO8b3OkcPyzrclI1F3dxEZrzhRjAZcozxNQ89ft4bZwFjCZPoUat8j/6v+iCw/XuuDG578MNyx@vger.kernel.org
X-Gm-Message-State: AOJu0YzXo5UqETfuMw6QKsiIc1vr7f2Ilb/sSAJ9dCx3EmxvfZl4fzOz
	XRmOu9h/aZpsF4/X8TVCd50hulxGhKM424pjhyrzxzFFd2kxIx/r
X-Gm-Gg: ASbGncsERBs7BkU4ixFV2lv/3tHXaJkjo+ndjoULUGOejf5CErqpcbouGwBDjSoRxno
	94rXuSMCD6SsNxPlVaRI9mLQ/DyugH/a3Hp3BQ01j9m7kqmhdla3L9gfGY5CGJvTPPnlCOWYRn7
	RnNn7GvMhuwzvIBFKkhJ4V2Kc7kg+YCI+B+VXdHYUvcUXp93+jIhhUearsFeQOlsySorDU33T1H
	Kb1cX8crJggBf9lH4MXf37R8mI/7val1R9UOj2moaTkCRzPhUJhNEcd6AxQ7hPTB3/ARrUDpKOC
	ZjfDL1KknkqxOXRTbaTi/cYM3Vahng8eKNoxGZxUIGvVzGzygVM=
X-Google-Smtp-Source: AGHT+IEOa8+IpbuEPDc7gAyIcz+T0tvKBmWOlS+MQPYG2yPPBrjEYLG3AtngfnrHGnIVnaiRdHpnyA==
X-Received: by 2002:a05:600c:1daa:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-438e6ed8f0amr20942705e9.9.1738310977796;
        Fri, 31 Jan 2025 00:09:37 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23d42dfsm48323865e9.4.2025.01.31.00.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:09:37 -0800 (PST)
Message-ID: <b7b36d97-cc1a-425e-8877-ff1bb4359bc9@grimberg.me>
Date: Fri, 31 Jan 2025 10:09:35 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-fc: use ctrl state getter
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
