Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2C3161BA
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696672; cv=none; b=cAAMwGHXFR+OEj+DUaWFkJOunHUDTONuyz+drlTlxERn1/l+pikVd0UTO6ZGtYMdUgMU0FQwGz1xxfO8rWslXVht03jWQd1KlEl6HOjkz/nDEdWTaQ4KFWcJwXO5CXvsDPVsWbLlKvGERQoBxTSo1UYQch4536fx/apFDUZ0yGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696672; c=relaxed/simple;
	bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKWBu8WgUwPg4KQBkg3/4EWlG5LG9gX5++4THaaq/1IdD4i8Rp7qTm/SMh5FaMFmt7auCVTJiDq33ZfQRTe4lxPhCe/reIKyuCrC8s59e3Ikvn5DGf0BmAgQ+t2bKY1+bPJeCBwXZwRW9cmmKXsVb0CXQ3rbQkBCRy0Ypr8YLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC6/9CJg; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC6/9CJg"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dde4444e0cso291445137.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 02:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696668; x=1768301468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=;
        b=HC6/9CJgEmFxZevNnWYNt9ZvzsZ5QpyvzKlcKyl9Bn0lnalzIeY+h+gW8Oxy2KxX1W
         VZaEUYZkXuuYYisoKu51dNhXvQCu+S1jtPxjSXCxFbz14EmHxsALgfOYQ8BYh08geqpR
         RkQq5PJDdEqkdnM0Jq2Fb8TgIDqk8Zr/dWmEMyBXmP4GFdJVClc9jxDkrW1+d/cVmgxx
         buahBBoWZFuN0F/87mdl12lxF2vy94Yt77XuoUGZv/UE9StVeMS0jaozN94xOS7ViJmQ
         gUepWhM2fvsH5ra0vmOl8fx2PahjoHuXe5isx2aIVKCBult0BU+dDqSx8ntoT4dJde9+
         HMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696668; x=1768301468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=;
        b=cbN9gM+tT4q24oG/6A4PmPjLyuABYOpQWVoZKO6FSYZ3tLq2J5WFyoxUD/SdCJ2x7z
         4cpDcZ7AXBH2Irfc+GGg4wbcwKzlqMQfdCeQspxja2WwGsXgy0G3VVvfWWEd4gKveJ+J
         wJmoA7WYxDLBptYY9v0ocqEiNanHMMK6AP3qI1VWigmriEG7vJrLnLxUjhFXKH7WEHoE
         /kWqmId7W/jEUQOF2VzFux+UUBbCDNpEUQXP8ez7ovi0M06oVRAW+x4UhDAiEKcKJJDK
         dJJh0Mu82Zi08+ZkrmEnrQfA3WCeSauRoXNYZhHdFztsk6u9FXWayVznDK2RqGK3Jr1J
         cufg==
X-Gm-Message-State: AOJu0YwJaBnVqeEYzexqQFGSvxHuMNXZMyqyZIFNIOWA5E+02NAuhsx+
	SkfeTtqnmF9WEq5j9+9sI4I0nAloQaH6fQ+NXYSjP0lQuzgyxIrdKhpleUHjnJM9Hhj+hwMj/Hr
	4n0doibQiEYQo9nGk03ZGS2EdY7iYv9k=
X-Gm-Gg: AY/fxX6h/rc8hZCwYu9P9/8PIcRu9YxHlg2ZCYR1ndCVDCB7Qi82OPVLVSuwK2tiDAM
	ov236DNQeLFMlpOs8Ec5rW461fAl+0dCNxW3sJBf12R/5siilm91FKIQrzJONPrwZibdfmBg0pj
	eQKUmErt6c/J3PdF7LEPqGsI6tVuZndANLu5EQ0PSMO6CraruD3pP4ESNzswAqqXeRJL4SdOcN+
	OOLcVG6yuVJn7XJ956bpOWt6U2W5Bc+SIf22T+juUMHd/8NcHkLzPbKpC43rqQ316IV/3dqprXb
	uVY5v1jRBftmgpPgWsmZaX4cxNcqPrr4e/XHhyo=
X-Google-Smtp-Source: AGHT+IG2uv1i3e9VAkX7WrpVZpEjcXmJcgLs40z5E6+u/p3r0x0uDL2AqAtu2qxiDLvSn4yhY/B10wpKS49o44BJQhw=
X-Received: by 2002:a05:6102:3ec6:b0:5db:ca19:f02f with SMTP id
 ada2fe7eead31-5ec74329ce6mr659777137.9.1767696668543; Tue, 06 Jan 2026
 02:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
In-Reply-To: <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 6 Jan 2026 13:50:57 +0300
X-Gm-Features: AQt7F2pteEDNo2W4ylDnO8TsfR4yxOikMZf8XxLHSY1WQzegoJEkL84ArTG5zIU
Message-ID: <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If a user follows the current rules, they will not get a write which
> spans multiple extents and hence no -EINVAL. That is how it works for
> ext4, anyway.

What if he makes a sparse file by writing at random 64 kb aligned
offsets and then trying to overwrite 128 KB atomically? He'll still
get EINVAL as I understand.
