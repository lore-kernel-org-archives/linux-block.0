Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAF12E5D
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280095; cv=none; b=ZsRh76dG5CfuVGW6quvXWgggbd49tRjzfKU+OUjdGNiiPl6yVD46Yli5zVrkWvqSKNQ+6lQH80NCV+d2psq0FxEuocxGfBflTfA66iUorw0qDBvmLVzKZhIULUBHjolfEgm2CjhQPJuVzE26BFeBZsOYW1k4TPUfC2zV4lgEV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280095; c=relaxed/simple;
	bh=IJ9dVlzhmp3vXtUeuj7z9BmGg75344UiTJkb4f5/HZA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F9ykOoz/oc4w86zKpX+ftuAj2KU7vXRovXZ1j6d4KfJGWOQQwp7wozDJqSsgthRG7sYXMxeEZYumBiVr5DFoxMkPOdSXocNWHKAW5Mn7oTDY+e0TyNpTJ3mKuMCmHOKLFKuHjY8fmDbki93AAovHmjRV+Eq/PnjU1nwGb+qr5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4IvkfkDf; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4IvkfkDf"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a7765511bso6551cf.1
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 20:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707280092; x=1707884892; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IJ9dVlzhmp3vXtUeuj7z9BmGg75344UiTJkb4f5/HZA=;
        b=4IvkfkDfProeZPnEK7XEToy4+UlEJPDuO8PKMHZy1aPTeOlWIB8JQSUomj9jEsKM+z
         vVokZ7yWQt0i4Yvfvq1UXLgKghcbrD0JNLsW3KcEoRrGDrjgb4RLQBt1H47LKYnIIL7K
         qLejxILVhIf6Bvdhf3BI/GuIDUCBdiBca4rC/blZ8AbUWaPYG7x+iBuG9vM4ZOleszvr
         dGI9e37SXiT8v9VNwSYoePE9GLeizEWXkKZvddDD/8juhggGel6flokD17OLdOBXcJc7
         MZf4ByhhoedlaZU+FvWmifr6zfeKejywhuooFKQKz4zCCpGX5myq+tOseA86pA5VwMSk
         hTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707280092; x=1707884892;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJ9dVlzhmp3vXtUeuj7z9BmGg75344UiTJkb4f5/HZA=;
        b=uLDvUPUn20Qsjg3pvM4znCNOMqA76SFeSmw2ZAWEp6MnPVYQDGUpe19fnOcctA+12D
         K5IDwmcXqzYPdNf8zaMKhmmgWw/gCVmPdLcOX+WPTy8Uq3SWgftB5OJZCOqYT5DsVZdd
         9LRSw6D6GDu2VSz5aSrOKAHvb4xh3gzIa9UdbX9VY75/HVs0nekl2cmNhH3cDtP8HBjX
         kpNd1epc+Bq9zsitb2XcCf1V4AWMTFBk4/D7u+O/aXVTM7vQVv64q7OnIlXij8/9q667
         zwgbE+NoF+U2KfDA/lRcClvZJ08g/VAfrI3uoggtjkBwn6BuabvT6Avy0zY2x6GHc+ut
         8iGw==
X-Gm-Message-State: AOJu0YyMwQm+eTr1E+HdJk35vow21kaJPnt/eUEzcY73HLG+Ja9zn5A+
	hpXwNBVtb0r22J+BGqmYFsZELmG0xNMXbqOQtikJuQMo5+qDsafwoWyrc169KFOByQ6FHxCnU9x
	fEKGfWWAAnuL5C5i2EH0NeqletkV9FULZvF/Zborckx1/49JoctaZ
X-Google-Smtp-Source: AGHT+IExXgVDoLcBMnmblo8/R1cJu7OqCSsI+lm3PdpMwaSqehPPnx1J6xlAG2RTGlqeP742S9RNm6NaoJ7nNpLeG9o=
X-Received: by 2002:a05:622a:268a:b0:42c:42e2:4ca9 with SMTP id
 kd10-20020a05622a268a00b0042c42e24ca9mr383qtb.10.1707280092105; Tue, 06 Feb
 2024 20:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Saranya Muruganandam <saranyamohan@google.com>
Date: Tue, 6 Feb 2024 20:28:01 -0800
Message-ID: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
Subject: regression on BLKRRPART ioctl for EIO
To: linux-block@vger.kernel.org, hch@lst.de, Jens Axboe <axboe@kernel.dk>, 
	sashal@kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am noticing a regression on the BLKRRPART ioctl after we changed the
blkdev_reread_part() logic to reopen the device with commit
68e6582e8f2dc32fd2458b9926564faa1fb4560e["reopen the device in
blkdev_reread_part"]

We now ignore the errors that used to be returned for
bdev_disk_changed(). I see that this was explicitly fixed for -EBUSY
(commit 68e6582e8f2dc32fd2458b9926564faa1fb4560e: block: return -EBUSY
when there are open partitions in blkdev_reread_part)

The regression I am particularly interested in is when we get an -EIO
error from the disk and BLKRRPART incorrectly reports success when it
actually failed to reread partitions.

Looking for advice.

Thanks,
Saranya
