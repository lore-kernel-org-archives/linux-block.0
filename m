Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA0338D
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520772; cv=none; b=CK/vOTBpOSroq7d54cNoLw+k9JYFO35ZGfiTSdHNRTQsSnoz+JQkjND32jwiQUAbfGEckVQGZBW8+mBEwDUIQ7xywLSWDytSBKO6iyXQEtehkcRwKSL/7uAB2zHsRp7barqhLNSlwP7umD/eJPbERvIPuboNAhTAFtHsr9HGlkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520772; c=relaxed/simple;
	bh=9pJJVTZZM3QCn+oui6V6Hn0OTNpM5sMorAYDGGh6gjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjPfL6E+ItGvzwPrIUyxMj5BDbCx+F1FbwijbZUOgzTUfoBSXXkOgNRSC5qbmCQlsIx6fumVvf4oIjb8VGt2z4pV+ym0tMu/nR2YcNRJqObV2YuJ1tvQ4XZft5OT+sWaZKkd5Z1rAoVZu7hkYSuzlaSwOqrWAObM/c2v/lEuSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UMYmIObU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UMYmIObU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483a2338616so32756945e9.0
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 22:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772520769; x=1773125569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2Ju36mr4bvkPwgZixZd3t2ngeaxuwiZ8lFBXsrk3Fg=;
        b=UMYmIObUN4/oM4vfYXnZUXRM3s9LASnYhiZNzk49OfX5dCqqH9jwwCByprsDUaQM26
         aQNtwWG08Pybai5dyO19tVIhW1UXZkfH5VGKkYOYGUteVFvX2KnCaZtaLmTK82EYhAUs
         mxNezfuR24MWB0ZylFIe/SajiNPDmKaSMybl46jeVLV4P+H4Fm/E+Y4p5RVhZ2qod2hG
         c0haasIIZq8edFaHW6MW3d7mP6tX0ZEx4DHvu8V1mQT+OEmQG58UHK6DZN/7a9Fw9Yzy
         puYatkbMBYXURzMXbZUYq5JSbMHXJLB9m6y9HkuZ5MHgwfPsX1o7FaXcL6xSO680KlAW
         YU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772520769; x=1773125569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2Ju36mr4bvkPwgZixZd3t2ngeaxuwiZ8lFBXsrk3Fg=;
        b=mBBcUYN3Wk1U7gpkerJOKWfgPOFt8ji8ZDdBl/yk/Y25lk9u66f05Rh4cNGfa8DDfF
         mJKTuA6RAtSTkSDzgNB1rHYEuZFGPIaz4e+rqfz9rNYvq+0lxbTvAWlXxhm+oyXqUjqP
         1nYQfMALnUcS0mr4eHTOyucSc9JflKDRq/vYEkuBrb6qRodWr+S7zX2MqczCQQKCcQe9
         ag+DDqud0e49vYOwxwJ156EE7EcrFJbxjeL9gnV9BnDukrU8jFQyqAdLRnkxjVR+BS5p
         /PI3GbVfU4hcuuf70X0o3tLxGgwwX5gaV+gN6wVL49trPP5P7aXcOcRMEC1Ri6iXBJnD
         T1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Z7co7K8jMqepZRzNb4vOfa+bp6JdqSrhDw4mbkF0iPMfu/MufPY/PeWjGzAMZB4gaKnfz40ZH63qdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KX/sTGuNc8fOOU15+HektG8TMCsnRVdQug5zv6x/pOCsfLiw
	yXuvs2DZfaKhVQkDSxh/vJGhiEiytQ8lduG5y+B7OddY52me00fKDy2Q8gSf31WLRIU=
X-Gm-Gg: ATEYQzzYFU3oNcqEHytNh8XsnDuPar5mTfopiSV0JqlDCL/0IHENLtcX4C/7+bnvHP4
	wV9j8jVU+HcS14aTVorbrzC2KjPgLna74LqYi47AhBR59fqfJ6j+u48pLo7/nBjySxYr6Jdn6GI
	6nQlpME7rso06N3jwq0L/CIQRabih+jpjykpipWyueOXTq6TZgKyuX3KOnE7wrC9px5Rx5hbhmx
	MgJ93SGWFcwdm8EdqpjtoOZicRP0HWDw4bXK8NizDqA4AnQj15l37OF+tE9rw3LM7T7GudrA5P1
	IlrzVSAYndRKdmNlI3lY2tP6n0IjhCNK95E02ILXk5K9M/MYo2SqM07blV7Q5NgrdjmP9o7U9Ix
	7xILWZu8LVWj7w45xWvlF44zvsm7lzPJTEp/063+NVjhjVL2R7SdaQHVNRUxiZKGbdZOQ0APft1
	j8PQr/CifldRSRL2J9yuFetmKify2bmHj6OKalTuBv4yQMFMiguDjZPAyplva2G9Jvjj3wkzT6F
	k5q
X-Received: by 2002:a05:600c:3108:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-483c9c1cd2bmr282993795e9.35.1772520769194;
        Mon, 02 Mar 2026 22:52:49 -0800 (PST)
Received: from [192.168.178.47] (aftr-82-135-83-117.dynamic.mnet-online.de. [82.135.83.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3ce8fsm329359945e9.4.2026.03.02.22.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 22:52:48 -0800 (PST)
Message-ID: <d79cb9d5-8935-45ac-b2f0-f86f0728bd8d@suse.com>
Date: Tue, 3 Mar 2026 07:52:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] scsi: core: add SCSI_MAX_QUEUE_DEPTH
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-2-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260225153627.1032500-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/26 16:36, John Garry wrote:
> Add a macro for the max queue depth which is supported.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi.c      | 2 +-
>   drivers/scsi/scsi_priv.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
Maybe: 'Add a macro for the supported queue depth'?

Anyway:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
