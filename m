Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E82EC56F
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257898; cv=none; b=Gm4fsaMh9Cbz+aPbGchHpb+2Tw62ElUAHN77z3ZeEn2Tutnx0KeooZMyDMXv7EJZo1F6yFQN0TAsl6u1ZwsqB5bfq8QfzPmCFEsKb0Sd8aEB3Msi5XiLAkjHOSRqUpf75qp9VgVan0EEFf37FxdhmjijxM7HCtgrWeYldll+ogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257898; c=relaxed/simple;
	bh=91j83r0a/744GsjSSpvMj2vPPbbmwRCLqH0NKKKQxTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=K8/octdNImSsRwmFjvmz95LciYZnwqM5ztiviKvLT8YuSNjha1wtSiWZU/CsHb3PzDRIqg6qMIoPEIpjqQWC2deb8ba490X8Ealtrn6e2rmYkpPj+cgdvsEtxVEUg3x14989uxAe5oDiptxzFoDb6yPSlnPF8TZcFDRuS3rE+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfPVlvIU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfPVlvIU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29524abfba3so40685405ad.1
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 04:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257897; x=1762862697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIMOgpEtwvgPznTb3R/noQ8H3QESHZcJ3b2FNe/UuI0=;
        b=VfPVlvIUyTV8qIihY9JjSsKeyNBWMl6UMFmRHCYWXD/joLcLMadxUuigePc7OhaZrY
         poj39NwZlF7+axyTDmSBJZ4OAlWaIr7WNFIwvrpEi3HxnWPGVIBY+gLnWoFBRlDDThYl
         j5zBzjXV9t/sahOazDTvFdKATZUWOqVN1tY2AzxYG1MId0HMuxoSEe2F6b82KB1ne/h+
         LEDmMa4nPJ6uRvAYKezrrO6KUc7QMaqhzHqVkUS40HQUtiFYcPk+XmZH/a9FvXU2/hf4
         6a80ov5PHP2a0+LlvS8un7oaNXSNfvizKWZKs7QCnHqx/okdk249o3XS+QCDKsBfTnTM
         /yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257897; x=1762862697;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIMOgpEtwvgPznTb3R/noQ8H3QESHZcJ3b2FNe/UuI0=;
        b=toFjhmCCgYHpSHavCk1uO5owJ+kRHJfOxxXYar77A5bm8bldM5EKajSaa6oKToiU6j
         lCvLyiPE/x9fFPVDyYBmJ6d80Kd5QzwtqaPvvYLX8Je6K8poZJITrJjKXo8ZWav1ZXOO
         IOlVJ/1T10xCQcdRYLpD/T+e7PXMYHA1jDGyYTzd4uvgUa9jUXK8LANayw5AU+FhbLCR
         NuyqLsYBeBwBFOuUNqT7IhgZRKRqRp5K6rdW3C1FeTovmTkbFCTeOl7PnROkY0w92u/g
         F0KvLkPT4/h1sh4Hzv1cAEGW+whJVb3qsJ6Y5PjtSyQ/iEPvsJAU2Lr93H5qf3DDrJiP
         CeMg==
X-Forwarded-Encrypted: i=1; AJvYcCUjQxlfjMYojIdXyZySVTdJ5B4qpXV9djIqAQxTqp08DjDz7v4QurDtzKFcaBgABQSe6kp45p6mC2gZbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydScS3nMkTt3nAJjiAmvNVJhXvlnLtJzzvw/jOz7QDL8yebmMC
	9BfbOBBAq9aWZJcQ6AS0jWIYtsDflVjUzZNhRj0y966oL4VJQkraInSD
X-Gm-Gg: ASbGncu1VVLEnlRTqNsFkuUB3Mb9cDWBD7n4NRLeaa1oKjF3ddxSUMyN9YAbs069KKE
	Il4L0i0A9ClEiPZBzYBDO+ZDaZ/7Hd4vrRKFyT0kiF5YH90QeX4hIllRDbTyINWsRMS4dW4gQ1h
	1rBicHdWYh/MX1K88Xm4yjxzgdwT/tCZ18AWdCU92QnCQP89Ah3ulGg7+tpAI8ALZVP50dhP6/h
	8ZHUA1iqCrSbdXZhKDV+09Cr6zL7nNhhCdT4pHi2b1v0NrYXy+bG9/M2jaU5qQwaivZY8on1fQ3
	vyhbCY7DlztYVA5+s/j+x51hlPX9wofMHBcuJ8BTkcE4T/bgqIVyFqcuWH2Icx1YacMdrQP0vet
	mxJZXCIUImlZuhDiEKYPUXw7Nei2HdkIunsxp9b/yFM9BAuTaNj/UpfTTkc7BYDcGrw+BWnW2go
	xkFB9O6v2UVcID60bKHOdV+0NpHH/LUmPt59WqF2V6O8CMoBO+8usfeA==
X-Google-Smtp-Source: AGHT+IHhptMGeN6GUWdSr3woSCYhxUw05Wn9RRD4O2T5DayZS0jhPNbaRMV4ZHTfd4sd7Ew85mCkaw==
X-Received: by 2002:a17:902:e88e:b0:295:fe33:18bb with SMTP id d9443c01a7336-295fe331993mr38565105ad.14.1762257896410;
        Tue, 04 Nov 2025 04:04:56 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.200.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2960199831esm24707045ad.37.2025.11.04.04.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:04:55 -0800 (PST)
Message-ID: <a05cde7d15d85f2cee6eafdb69b1380c8b704207.camel@gmail.com>
Subject: Re: [PATCH 2/4] fs: return writeback errors for IOCB_DONTCACHE in
 generic_write_sync
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>, "Martin K. Petersen"
 <martin.petersen@oracle.com>,  linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-raid@vger.kernel.org,  linux-block@vger.kernel.org
Date: Tue, 04 Nov 2025 17:34:50 +0530
In-Reply-To: <20251029163708.GC26985@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
	 <20251029071537.1127397-3-hch@lst.de>
	 <20251029160101.GE3356773@frogsfrogsfrogs> <20251029163708.GC26985@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-29 at 17:37 +0100, Christoph Hellwig wrote:
> On Wed, Oct 29, 2025 at 09:01:01AM -0700, Darrick J. Wong wrote:
> > Hum.  So we kick writeback but don't wait for any of it to start, and
> > immediately sample wberr.  Does that mean that in the "bdev died" case,
> > the newly initiated writeback will have failed so quickly that
> > file_check_and_advance_wb_err will see that?
> 
> Yes, this is primarily about catching errors in the submission path
> before it reaches the device, which are returned synchronously.
So, what you are saying is file_check_and_advance_wb_err() will wait/block till the write back
request done in filemap_fdatawrite_range_kick() is completely submitted and there are no more
chances of write back failure?
--NR
> 
> > Or are we only reflecting
> > past write failures back to userspace on the *second* write after the
> > device dies?
> > 
> > It would be helpful to know which fstests break, btw.
> 
> generic/252 generic/329 xfs/237
> 

