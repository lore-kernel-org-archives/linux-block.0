Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CA5FEEB
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XPZGz+ja"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso78066539f.1
        for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 08:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705075845; x=1705680645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFWfwHygc2tLtqaZ9kmrB7jXlZ0tclJm6WoKHkdH7fk=;
        b=XPZGz+jaZFS4t2ooJLCdCoQd5eh1V0fJ5CUlVcq1sPAlhk8/gLMs6LY+TmI2a7For2
         bLtDH23MmSRuzgjFKhKOcWo8DG119j3h+iJjS+u3UFF0fEUvr6BINhUs5vRflBcRjTHF
         3xvVm2d+QzMc1hLWkf8dQRG4deMtNWpKFVkaHR6XolUiqxrlZ2jSdCJ/HgnDZ7iw83A/
         MKyXzSX2Ebk5zBXd8ZdO/PhtO1mBbaODd94sSe+ns6zQV3e3cRMZrwes3STg6a/AtkL8
         bd18x6ZAjWaIfzhfRYu9FdRb7lK2BEqI3y4+TruuEmBbNfxGpggvthh+IlE3aRtWvjA4
         b/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705075845; x=1705680645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFWfwHygc2tLtqaZ9kmrB7jXlZ0tclJm6WoKHkdH7fk=;
        b=CeKlZeN3vYFqANuvD9pllFkvbs7XsN73c1eaSKaFn3NF/80Z1PQOjc4Ef4BNCUps0T
         V8hW7llXVJHcLcteaJLtD5kvQNDX7ozTYGJWALHsR0W1OYCmtQhsI6RL5Rw92yCcdph7
         hn8sNhs0GvUxtisMkM1oUmJrYWJPpBrssaM6eAvcphQHiUzJ+YYDl/vIZAHIgT+exwCi
         Ck0jOxxnBcbQ/b5/QJTCNWj8e8x6sLJ1BW9cpzynfLIcwzbBVMit7fBCYXHe7Upn6ymP
         oX6ECSHDE9Sxqo8XFWU0UMSTSvHHJeCPrB2I/ZRM+/rq6nqeKb7Qoqm3dYhk+A6Fw0Cy
         jLSg==
X-Gm-Message-State: AOJu0YwhepFh5VQs/j0pjdQXmMLZZD6VJpen+Vo7C4DmJkOfseO+XtjQ
	e3f62dpLx59jZmN+Dwxuv5TDxWHLoPNq9Q==
X-Google-Smtp-Source: AGHT+IE5HSi9IwRSj+Eoiwy+OtCZgGENx3FKGiQyFSFBSLtYiehianEJtjDF35mgK6CVa1fFWXukmA==
X-Received: by 2002:a05:6602:2558:b0:7be:f413:e410 with SMTP id cg24-20020a056602255800b007bef413e410mr2103714iob.2.1705075845625;
        Fri, 12 Jan 2024 08:10:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dn15-20020a056638090f00b0046e300e90d5sm937976jab.152.2024.01.12.08.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:10:44 -0800 (PST)
Message-ID: <d495b5da-3bdb-4548-9876-78f2080e15e0@kernel.dk>
Date: Fri, 12 Jan 2024 09:10:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20240112054449.GA6829@lst.de>
 <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <20240112142509.GA6899@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240112142509.GA6899@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 7:25 AM, Christoph Hellwig wrote:
> On Fri, Jan 12, 2024 at 07:22:18AM -0700, Jens Axboe wrote:
>> Yep it is pretty cheap, but it's not free. Here's a test where we just
>> grab a ref and drop it, which should arguably be cheaper than doing a
>> ref at the top and dropping it at the bottom due to temporal locality:
>>
>>      5.01%     +0.86%  [kernel.vmlinux]  [k] blk_mq_submit_bio
> 
> Ok.  Do you want to send out your version formally?

Sure, can do. I'll pick your first patch here as that one makes
sense separately.

-- 
Jens Axboe


