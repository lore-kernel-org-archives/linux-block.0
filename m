Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059E3D6CB4
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165491; cv=none; b=pP3F8V1ueUO/hfKnYWFUEJROofMj2kHr7Gw8najUwU/RTcTI/pckYnm18q6sKfISnHIXLLYQ3EUS37bTXaUVlbKX+fC7XFi48ZTO+BZipexqFzBOrP9A8yQNHNHGdZ6Jtx6mfUJmAtmrmezpsAp2FKZlinVR7J2pp8EfUvalbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165491; c=relaxed/simple;
	bh=WLtm+GBjS4mENbZdWq6ft2W9jH1OWPirkpQ5szhajHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGYxGZEMOZ8NytCqDrM8sj+Qzu5/Ap/r1agRm9TA6n3XMmt80PiJbvIc4L/zFVymcwB78Op68AJ1ysRUqNpYtEpIcPxqf9oJMfcgRPY2HBnDh+40eaPFCI2c/adJpFS4PqCfKSYr3SVARCg6zBdkbuauqtF9xOTIGe/LEp6HbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtcOLTG/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtcOLTG/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so1195649a91.0
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788165485; x=1788770285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wvmBjNWujEmlSCyP5EP6vmyuBGO/nrT24KCWQT1TNSQ=;
        b=AtcOLTG/e8e8yduYS9tgCC1O5Dqgq0qNkM9FL6xjE+z6VAdoOOHzBkQvXfy536lN4H
         KlOpYy8g+kAF5aMzcCYu3ATuVbOOi95u3G9MccHKVVsLEMjXdLYt3C8LpebdjTYCT0sB
         lIgaw5TAPQ0JMhrtLE7VDI5UYHqT/VMC7U2Tt813tnxF2itGXWMQ0WU8V+r12UaAG88S
         Y3NvcOXzlssbXOmpeKQydrDGPpd1oghGf+ZbkLuF5HBS0v/n9RB4dPNnybWQdYjD7Nkh
         JrMc0VzVShlD5oZw5zi5YbJj6VPCstqab7kGYXLhCSkP+RGbmURurLP7EDKNBEkFVJhF
         WTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788165485; x=1788770285;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvmBjNWujEmlSCyP5EP6vmyuBGO/nrT24KCWQT1TNSQ=;
        b=ojZ+p5/ed6eFCnyBDJLmeUkz58TSvqy5d6jV+kvvuKXI12cCTpgw5p0gMLys+Dr51G
         3aGetbtXzdedO6KOz/rCS1+zjGiuCYLlCPEXDF5Q/SngP8Sit9u+sfcEXOZCK55Wz8y+
         Pd3P6IWAf8e5p28mHkxdJFfg+Zin/YEMHshN3TvVPH5J2k3T0Q9xPA3rqZUocGcB3hcH
         wnGR8AQ3xgLjwoOQf/6dBBw4fjrA+gsVOnfeDm7nJqRfQBPE7SR8O0BZqzWa2iXIzTPs
         6p4uKLgfu0OoY9vj5sZq0J6FlUWhq+RN7QTbyrJjbk8HSAC9BmZneBrlMStNLCa/9nFs
         BoGg==
X-Forwarded-Encrypted: i=1; AKwUvBwF178NGBhbQI0BhpnJSME1JZlpzrcslBYhOftDp+S0eRll2eZcrICppesy/rkS97iAHWoFFud5Zh9APg==@vger.kernel.org
X-Gm-Message-State: AFuF++kO+GkcVaMPOBhAfD8Vxi9Ff9vk1tN8BnBGlQRwavCLkvw13Zpy
	PjyAkwNepaPmT/H+hoevv8s6yDWUj1fclRRo74b2cn7Ol9l09KHDJQ837WnCBA==
X-Gm-Gg: AYBFou06UVWDTy7Ac4x4QPsgn0xXtgZsmlL1sJYysoyAo2/tPOhA80n/bW7TrPOAbI2
	jSH7B0iU29FoZXO4oefqwC/NYTm4UzaBKn3b6ayjLw0hwv57vMMV7F2Q7kylF91WGB4ZZnV0Hs9
	r3/6tna1w1asdYR6vdVdBJwz75BbWapvoGCgpXMgGLQ6rMZ0+43YM0XSEBX0xNTMx8tbtTmyTE8
	qOonjVFnwStpK0GNfmkmaHGWbEiOeoYOaS3gNBpZNLC+Nao5ruBPpkFedHcQdutdO8uwAZGHwQx
	PahZrOIoFpuomoBJd/6WpXJxHBe97Q9pRu2mM9OMH4EV4jAvYJj319V+VwjSSSVuclM4bXIqlCs
	jlEG9JCWJ2YsmA/g95lSQ2iFWC2vGRJSCqvLE6Ayzlag+bZIsjcniWoeJyZA3Vedt0s7reQclfv
	XbinPZ131gHaGpv46t8nB1+WfOQ77ZlnBrQm0dmy75CYyF/8VA2qE3sJo8wHDWhqmS5XYzbP2Jh
	pic3Mw0vvb6uOHJQhU=
X-Received: by 2002:a17:90b:388a:b0:398:ceef:edde with SMTP id 98e67ed59e1d1-398da8cf414mr5021997a91.15.1788165484692;
        Mon, 31 Aug 2026 01:38:04 -0700 (PDT)
Received: from [10.125.192.112] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d7853da8sm5066022a91.4.2026.08.31.01.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 01:38:04 -0700 (PDT)
Message-ID: <c961850c-09d0-3366-73e0-1932c1dc00e5@gmail.com>
Date: Mon, 31 Aug 2026 16:37:55 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, minchan@kernel.org, axboe@kernel.dk,
 bgeffon@google.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
 <20260828102446.3eb7f3dc779753b831e33fe6@linux-foundation.org>
 <apT-ocFYDmU6iC-j@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <apT-ocFYDmU6iC-j@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/8/31 12:15, Sergey Senozhatsky wrote:
> On (26/08/28 10:24), Andrew Morton wrote:
>> On Fri, 28 Aug 2026 16:31:49 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
> [..]
>>
>> Thanks.  Sashiko asked a couple of questions about this change:
>> 	https://sashiko.dev/#/patchset/20260828083149.45760-1-jiahao.kernel@gmail.com
> 
> 
>> Does this early return prevent marking valid boot-time pages as idle?
>> When a page is accessed during the first second of system boot, its ac_time
>> would be 0.
> 
> There is no possibility for zram to hold pages during first second of
> system boot, regardless of whether zram was configured as a swap device
> or as a block device (mount-ed with real filesystem).
> 
> 
>> Can the early return above bypass this zram device initialization check?
> 
> We already do that, e.g. when kstrtouint(buf, 0, &age_sec) fails.  Apart
> from that, that's not how one checks if device was initialized.  We may
> want to consolidate those checks, just for symmetry.

Agreed on both points -- the early return is not a new "bypass", and
the write() return value was never a way to probe init state.

How about moving the init_done() check to the top, so all the early
returns sit behind the same device-state check?

static ssize_t idle_store(...)
{
    struct zram *zram = dev_to_zram(dev);
    time64_t cutoff = 0;

    guard(rwsem_read)(&zram->dev_lock);
    if (!init_done(zram))
            return -EINVAL;

    if (!sysfs_streq(buf, "all")) {
            ...
    }

    mark_idle(zram, cutoff);
    return len;
}

The read lock then also covers the parsing, but that is non-sleeping
and its cost is negligible.

Thanks,
Hao
