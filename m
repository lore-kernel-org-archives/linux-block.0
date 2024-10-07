Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7971DE8A4
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332561; cv=none; b=JqLU7QksU4/aad1+7KATK9D/FHQVYgki2lEbipDdDsCGXJokBKvcr+Gq7+ElXrsZDF8RLylVowgGyBLfVWI/zwrfu6KZSSmgBkYAM3wSq8JA3+SrFDT5WdTGh9kzayf1TucHDnwTWb7ISB2JVjHi+iYf4i+LiPaZm+wUpf1oz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332561; c=relaxed/simple;
	bh=21qP7Tak30Olxg5P/qZkkhpMiiPnYGWRaPxCeAM+y1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t3c8d5plMzkDA8p/ZwE0m/LCBFF6UNb/FMatpv93HqN0Y4smPokYJIH3zJITco4Uvi8upn+t6GWd9GJzubdgwt9CVXo47GOrBeUlwYtqCJ2SKhc5RJDstPWxSvoPsXZqUQVl97Rs+xgrseO9/te6UGTlLFgyPpZxi4TLtibVBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sN9/6zZA; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sN9/6zZA"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82aad6c83ecso185419939f.3
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728332559; x=1728937359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR6hQb9CxfxGMdRoKEcbQoEJHNZRJy3CqaZVl8rk6E8=;
        b=sN9/6zZAeOFePdDaBTA+XgqxPXDnhzUvUCLZkR+wkVug7cgTVovVHqFG9JoG190bg9
         DkEpoY5vSRYeRqJr9j0xgg6x514wQApy44e/ovd8QvneoI6moU3nALb1/VQxBc7yoQLI
         EIopDwk+9QDbqcDBOoMdPllEywrOXInGM3ZJqgeQBTP+AkIbthN7h6zdmyKVAWyRZ0kA
         TzaSGq5RDuzCLFu3bzyuWB9cBqPG48uPq5ZT4iVwHqEIohSYofo6qj8b8QF6VRw4J1fF
         O/OPcauhJW45fl6U0gSwgLuZNRNhY/Rdr9Pde2R1wfHKr75HmZ9G5wr/U6wRVu+dQK5o
         UlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332559; x=1728937359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR6hQb9CxfxGMdRoKEcbQoEJHNZRJy3CqaZVl8rk6E8=;
        b=GFDXWkd1yQt63zaUhI9Arjc9xkZsv6anGdWbngco7XmdTHw5mgobPZ+/DZrNoNRBXh
         UnfoAZnrOiFIgC5b77T4YEFI5Gc3zRbjTbAqqOBuNXyjmLS8xuO2tz405/RzfQcNSLtI
         JhR5OpA3xfRhcIodutiNC4AHQu+USP/equcXwcCC96gNP9iJinX10FYBvbmmS2Txq00L
         GAz8sRdA7zSnn4MxjG3aufFEyQo6BELzEo12UJYvI1ZV6+Pw/Oo1u/RHpXktLVfBikqq
         KRtlddNRliW2IjRjN+/M1iNbl5VNDucLOy1Umu0zL7LiNYyEfaRx3+TaiADiDlXjUJ4q
         O/6g==
X-Forwarded-Encrypted: i=1; AJvYcCV20Whk3RZ05gs/iyqVYbtOUHQ7/ADOD2lOdFcKFo9KYK/ghBGgX32bowZ8gMp2LE6JMmdODZPLWf9huQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYt1/fKxK2o75qGXM5SnSVavyIDqhBZWZnX+tYyhADEypZHJK
	5qTSzKpBv78lhht+BFQaDIglrtno1qOARHamhMa6J7VIp/P2N31lm3mJs2GUogQ=
X-Google-Smtp-Source: AGHT+IEAMVfOE5sPUtiSwm/TWfv2tfGIIhjiTnyU3vDHUtq0SM2wY34KGRRxJU7Br0YzNi0Fry8+GQ==
X-Received: by 2002:a05:6602:610f:b0:82a:2053:e715 with SMTP id ca18e2360f4ac-834f7d93c3amr1217728039f.14.1728332556273;
        Mon, 07 Oct 2024 13:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db86e86898sm605463173.61.2024.10.07.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:22:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kyle Fortin <kyle.fortin@oracle.com>, 
 Douglas Anderson <dianders@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Christian Heusel <christian@heusel.eu>, Jan Kara <jack@suse.cz>, 
 Li Lingfeng <lilingfeng3@huawei.com>, Ming Lei <ming.lei@redhat.com>, 
 Riyan Dhiman <riyandhiman14@gmail.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konstantin Khlebnikov <koct9i@gmail.com>
In-Reply-To: <20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8ae8514dc004@changeid>
References: <20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8ae8514dc004@changeid>
Subject: Re: [PATCH v2] block: add partition uuid into uevent as "PARTUUID"
Message-Id: <172833255467.162249.3695820190422916095.b4-ty@kernel.dk>
Date: Mon, 07 Oct 2024 14:22:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 04 Oct 2024 17:13:43 -0700, Douglas Anderson wrote:
> Both most common formats have uuid in addition to partition name:
> GPT: standard uuid xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
> DOS: 4 byte disk signature and 1 byte partition xxxxxxxx-xx
> 
> Tools from util-linux use the same notation for them.
> 
> 
> [...]

Applied, thanks!

[1/1] block: add partition uuid into uevent as "PARTUUID"
      commit: 74f4a8dc0dd8bf337edacb693383911b856f61e3

Best regards,
-- 
Jens Axboe



