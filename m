Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20F12CD88
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943659; cv=none; b=u18zypgymvaHJk6yQyAoQuWrvQIhB9u54/M52Q9kPxFH1NqawcElXEHF+amQwVlAluY1t9RyLDF+ET+q/2qra4On9rDvH+Kzl9SZAJD+LoSdLakviMynKDfWTDC6WMw/ybvt1pYVwaamtGDSweF8rGtTXhnHhc8Pse6Jk6mgSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943659; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr1ZA/2QjBWu6vAOLIHakX7uRezhpPOkMi2R9iUBsw/pVUWkLVKHM5qkI2hRqw/vi9m1/knVIuweY4G5Qj0ZZNVXrE8aYh3RL7kf9yeHAtP6hAmSNktIErzbA8K6z/jrqHIMlJsHaDir4aGB2kn79KbEdcS/iVLIazT+DKB7KBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDYYTH/D; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDYYTH/D"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84e842c1673so245811241.3
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727943656; x=1728548456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=ZDYYTH/DZhNRs28p+Ws7i/uTT7tIj81zkHeEnOv34p4LbMTOa6LHTfIDLJtFvPmFRp
         HmSMSqdcAPxjp6ifUsfGh5q+TmhJ6j/JZkA29A2FVd90UBJ77vvNBxC1YZ96mGBqaFMd
         0hcdzAWFrysPJXgd8wQu6fpxnJaaDpkwLSWzpiiUTW/4RQ98qNjd2oaOcQmM+NxLczxj
         D4490Ix2V1PpdfY5E291ldZOsYcIHRUIUnER+k4XrkBWi7mR8BDbkhMYHPxlfFQusvH1
         EUV2gV8wJ1DchWZo8yiJ10EeesAySEh7qLzrv+2I9m65AKzqiSflMXgwbgdBtZzDkNq8
         PZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943656; x=1728548456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=MGVl5H8C6AsWOQXKmadRFfAAHa0Ft2Ro22xOgYZkj3+vGYdl4kK/r5P9jOXm8jy/EH
         NUTL8dsmZCt5F+4RWD1rQyo4CzRrgidpBl3cExRlcMVWzDM2QtjizLrxuq1s3oFNMySG
         Ohgkx2Fv9+aVeZ2UQPuuIIn8EWoXsmBe1cY3OmlYjprcf5lq2/zInuomF13CvuPugDIp
         MH5iPuTU6CrqAHj0+eQG67blFtqywu1yF4DskYDrdAgQEK2Eql7/wU27LYcLpPLGI4Wk
         WLx1muRVdPgCi/3uRwQObWSaASOcGvTNPqKW2J6W8L6LDMRrOd+9k4Jhs5OfrOESpySh
         Slqg==
X-Gm-Message-State: AOJu0YxsrbSxlUNxmMZADGNrRDVGuvKO9ib4KsHviXJ+j8QsxksKU5cM
	9xauAO+tcQRwzs7VEFEKK6PlCrVW0IkxP2xtphAANPGwAnHnftZh8INa3CpmAWbg2qbBbztLhuF
	5NXgop9DQ4U9BimIWoTSy93tvJ+45GiI=
X-Google-Smtp-Source: AGHT+IGk5mMQ6U2yq63hl34ysxH9WJHzZM00w9H/vCWv7s1t3i8MrTdey/C2rOe1fKo7Q4VNV8A3bhJwWcNff82gi/w=
X-Received: by 2002:a05:6122:1821:b0:50a:bafa:aa78 with SMTP id
 71dfb90a1353d-50c58107b80mr6063052e0c.2.1727943656179; Thu, 03 Oct 2024
 01:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aae722e-e815-4fe9-8321-86b062f517b3@kernel.dk>
In-Reply-To: <2aae722e-e815-4fe9-8321-86b062f517b3@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 3 Oct 2024 13:50:16 +0530
Message-ID: <CACzX3Au_3kwSmUnMJdz3CmRO6Ab=cH73=5gseXLeYxeX=TCM5w@mail.gmail.com>
Subject: Re: [PATCH] block: remove redundant passthrough check in blk_mq_need_time_stamp()
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
