Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05636B902
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894132; cv=none; b=FJaOOGNRWUg1Sep7PYLeqQ9gaH5aQZIUgWPwQR/bZzqA8CYsyr4O2q4oyn00XZ1zXHfmAz7Pc044MxphQownKRaOAysoOMmOc5Na+A2SaQdM489HIntBp3ojK0X+vi+FedAhzUqGa/P5xkGfAYJBZFbAIeKShnXbdMB3TS7ACVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894132; c=relaxed/simple;
	bh=f2OfvF0zOjW4sglyBB4BaW6dzOvj/AuzuvNWPG0TOrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoyPx+zGbID9nM2zCAgV0KA00uGKGXv7gvTBK8HQff23KXJToUNMImzVl/WVk4WQ0MyxY0CU4DJukDq28hzl/LtJxEhrlGbt3AfW0tlLwwcN0FyZr1t1iXwwH7ar00wj48g4UwzOQaayCs41+luQxXqjnFkwEoc3n5ycFlZHWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PjUHikBA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PjUHikBA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3900e39d935so414122a91.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 18:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785894128; x=1786498928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uBopClRFAHq7lWJmndH9aN//45165ac+gvxu0fQT+uo=;
        b=PjUHikBA0p7nFFumAi1JhSMCuYUzRBCX+wWp8ZWeLYE5gLYzWKomP+ckSf9BEmQaDI
         4kQA5fa4e8NV9zrMcwVMeuBI0i40vYXyXJpsRiMmrr5EFdJ6qasoKGAPzIy057C/Pcei
         T7wY9S1Yb0Z4xFrMnWXswM3re2xWplQ1cKZOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785894128; x=1786498928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBopClRFAHq7lWJmndH9aN//45165ac+gvxu0fQT+uo=;
        b=FsWmTbO0ulHKd6HtaVWzeRL8x8YTHGY9tHehIJGn5mb/wyV3o8aSB5pAOHtpy33+It
         2LEbDiBIyHte1GhduXr+wjEWL8Zw2kGHzxamhiDHz1dQIgtm5osv43zlIMp9g2iduIhp
         A99/+6GJZ854KlwV87u4YJgBVpVD0tNC3wMcbXOZdtc99ZrHL/UW6tv+ZgT3NPMR0qT1
         p2hFogniOXJ8tovaBrB2DZjBjLL5F9GSngEKdX2W4N5aoq0GRXiuBEd2h618SO7zW9J6
         xwnYAppAEZTq/Bx2XcLIe+Bqd0Zhe5G7e93uttS/keGuewhF39bCaV398dzJp15+YVxg
         JUOQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRgWA14ZQLP+pjjLkxOnstOq7C2cVK0QNEnICIDOf/SErm0uzMEHFgtlNSvmOPJ/QvJgFW4DD5k6SZsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw93Ksf1PMm1fvkLa42qptZUpyP8s/9BKYruMmzvtvoT7uKLpwy
	+oMWIuEfvlCd2EWQGZp2jNHJ4NBuV8iNXqlpdrV+2wIctGE+EsrPbL3RuA/p6CgsHA==
X-Gm-Gg: AR+sD105ojZc1ij4adAemMKXwIFLihYUOQTNYPTskeTYtss4P5jfEQZEcqJNx509Uce
	9/iPcyRvjOfayNRg1CdlwhgED1lVtW9IlfBPqHRfw2CNVBzSNQSRVnYg0Bnm7tyLaNcZeC+tHwz
	UNi/Wm4DpsuP7CPC4qjrvB2ALC7xhpZx+0PTfxI9hyR+JH+I5lhbKu+TQp5ddo4EB4JFty2HfS1
	Ay3AqMIpgv17qcHB7/DJIDRi0ZvJ8122l7OrvY5y4ikn3SMgxovJ/RljF5pd/3CeXy7eMuwj6T1
	q61Ruy3NAPiR+MBx+sUvyyq7Q3YcrozVZvHRhGPcjwSoLUuoJi0DY3Spv34GF4y7bclKWArkvwO
	dZKkL/0ZRLAVgXVna6zy+KAyYtk7oyAkjAxeEPeKvP4SJ2QR1lJW8LbIWLLAXTqBgyWjNkXNhDN
	93HrXiKzBMcm/Rh8myW7Wb0Wcft/X3J0Wu6gEL9G1B0KcYyzTXOTMiF8ysxYhw5YCrG7b1aK/Lr
	fGU8QB52SRAjtn8FPTsmdbFnUHx
X-Received: by 2002:a17:90b:4b81:b0:38e:7f1b:efa with SMTP id 98e67ed59e1d1-3903c582798mr2880279a91.11.1785894128429;
        Tue, 04 Aug 2026 18:42:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febffa549sm2619771a91.5.2026.08.04.18.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:42:07 -0700 (PDT)
Date: Wed, 5 Aug 2026 10:42:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Longlong Xia <xialonglong2025@163.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 0/2] zram: fix stale scan bounds after reinitialization
Message-ID: <anKUG5B3qfZRVf8n@google.com>
References: <20260804065919.3970386-1-xialonglong2025@163.com>
 <20260804131046.7c485858542d586bb7c51857@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804131046.7c485858542d586bb7c51857@linux-foundation.org>

On (26/08/04 13:10), Andrew Morton wrote:
> On Tue,  4 Aug 2026 14:59:17 +0800 Longlong Xia <xialonglong2025@163.com> wrote:
> 
> > Both writeback_store() and read_block_state() derive their table scan
> > bounds from zram->disksize before acquiring dev_lock. If the device is
> > reset and reinitialized with a smaller disksize between that read and lock
> > acquisition, the bound can describe the old table while the scan operates
> > on the new one. This can lead to out-of-bounds slot accesses.
> > 
> > Move both bound calculations under dev_lock so each bound remains
> > consistent with the table throughout its scan. Keep the fixes separate
> > because the affected interfaces originate from different commits and can
> > be backported independently.
> 
> Thanks.  AI review found several things to be worried about, all are
> pre-existing.
> 
> 	https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com

- u32 disksize range check is fixed in a separate Longlong Xia's patch.

- read_block_state() read of zram->disksize outside of device lock
  is fixed in this series.

- read_block_state() tear-down is something to look into.
