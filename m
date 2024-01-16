Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5340BF7
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442640; cv=none; b=Gg8y2NP+azzsRK6qcsXqXxl8IyHhKIuFuwUTyjHH9B+oVl6TAlDHb3tsu+c+GQV6Ov3cuiRwXMyuZ479sPJ8rBzYWjrbZZggeO7f6NKFOmFb4S5XG3jN2h1hM7bio0BaFNNBLe6DRkC+SKL4DSLLst+5GMrvLbf+RxbT7avhO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442640; c=relaxed/simple;
	bh=D7xRpJrIqjZP5jeWAvqMV/IYv+apGd28JjwDTM2diXs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=RCpOmoTtpMZZaT2xS9MzcTFdMfRblXUcXtghYUD19EezwhO/83PbFk75cjt6b5n1FqKo9t3wKbSkHZtxU8OJ1W1OPRr57gv2ny6fpvWlFS9n1o+bPw+YcJ4mZpAM7PdnE+yghmLMzDhQHN6aHWLOdzBgQbZdMZdeHk1VvjI504U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QdQDZgKz; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QdQDZgKz"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so101036839f.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705442627; x=1706047427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIyU1BRIYxs21GRQFw4kCtrNUaHNQwollWRLcZszYHA=;
        b=QdQDZgKzmk0ADC5AWridK+DepYtS6VQc7YzHXcMvZ84IwZqjHceQrKLJtcmjvKB4VD
         2Almx5GkfUd+joveVXgAivBVxPpTl1z3nDN3Eu7iR2VkuIIeUeIdsmmfdW2S2owV9mwG
         7r0sWBAQDAmUx4ZiRZLoTejTagPqSfR5hkX30nbjsWHDesxyA/vTMaCl4wtt6D0asu7A
         5ll+b37D5twOG/a4WFJfwJuN7irrRrMPZsFJZSPlKMr7E1cQVNlljl+e0rnWJDjA73Mb
         7WAKMMafQd2JQ9UdGiLURYCQXa5y4Ym52OlkOlJHDQ2dVaJJ3IxUHkV3tD+jsiFiBoP9
         x7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442627; x=1706047427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIyU1BRIYxs21GRQFw4kCtrNUaHNQwollWRLcZszYHA=;
        b=WbdROAK1rxyRVwVuK7QFvjscG6XnbVx723pw1ozog5teALCDyEHY12+lF8THN0uPa9
         YXvP7O5riPGsSJb//7e3BWxNOBAV9YNT1JzJox7tSM7BDHOmexDViR4X8w5ZDXg0jwx6
         hQ60QyXcHtJtg0jHDdPvdUvjwV+1dj7x63Ykd5PWHdOtCdI4I4CcgMsk3+K4PrnUR+I2
         NysUZGhv8cXcv8KnU9PM5wbWMEVeFCGypeqg6TbzQx7XYZxn06BlY41lLZHNQooFowy1
         z4PinGXf5ZEyH4X5vbAOsdHS9ckFXey0ltRis/i6DRgAx7yMBGqgBF5u69d0XX9xH5RR
         GLtw==
X-Gm-Message-State: AOJu0YyRLC2eJbMIhjiYHNtK58FbXIUF/LXsMigqqbsuLqDg7X86GBfy
	1YyZngkp918iSqCz8hF47FDHxk/OnvfR7g==
X-Google-Smtp-Source: AGHT+IEBhVEzbxUPC/dV36xmsUmmiGJEMiU22plQpZdebatedQSaUvgxWn8PYaTSAsQLbvD5Z+85NA==
X-Received: by 2002:a05:6602:2c95:b0:7be:e080:6869 with SMTP id i21-20020a0566022c9500b007bee0806869mr14083792iow.1.1705442627249;
        Tue, 16 Jan 2024 14:03:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l14-20020a056602276e00b007beea806d89sm2964862ioe.41.2024.01.16.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:03:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com, 
 syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20240116212959.3413014-1-willy@infradead.org>
References: <20240116212959.3413014-1-willy@infradead.org>
Subject: Re: [PATCH] block: Fix iterating over an empty bio with
 bio_for_each_folio_all
Message-Id: <170544262659.494117.14502342650352587808.b4-ty@kernel.dk>
Date: Tue, 16 Jan 2024 15:03:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 16 Jan 2024 21:29:59 +0000, Matthew Wilcox (Oracle) wrote:
> If the bio contains no data, bio_first_folio() calls page_folio() on a
> NULL pointer and oopses.  Move the test that we've reached the end of
> the bio from bio_next_folio() to bio_first_folio().
> 
> 

Applied, thanks!

[1/1] block: Fix iterating over an empty bio with bio_for_each_folio_all
      commit: 7bed6f3d08b7af27b7015da8dc3acf2b9c1f21d7

Best regards,
-- 
Jens Axboe



