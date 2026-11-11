Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399960;
	b=rV+ADiB2FV6/HNL06QOkwjI4OqoEgnkJh5utZVD9IKn1jFY2QBIx+vzJsHrFQLTgL/G6
	 m+x505GhcLNvA6+lTg0nH2RtV+nx+hEokRWXZZpTHiCN873kVPEQrg0EDRPW6gpkwJPE5
	 qL6B0khwSluETIX9WQqYBXR8+PeG87SCf/zaBZCATrnLn5mlAmJrkhMU8qiyM6jNwrblR
	 66+AmAvN9ZqV8IKXwjdyknpm87RIMPFd3OeXVZwVNdxb1XltXw3cXk+CvkAfDTG0Og2nN
	 Y2m04Dy81S2JlSxPgHScOgoAtfXm0y2djkjD4SWF7UxASduIjISsJOHXoG5zNt/kUhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v6qCUK/k525EVdn9LPhwOUX31G8ImRO+TNKVLJQDtUk=;
	b=AMopYIhO+j8URKbR7j0bDirmNfFbkVmc73hANdTYLImXQre3xS90Akwmw6JZynXaN8Ix
	 sHvQTvrLcVUbfkRRWVyl7ebid2PbW8dx+leEcudjnDqgkHlTG7zJ46Ys/h78LsCgD/yGE
	 DRGVdvupEAD3c71Ys2hjmPCtOO8tWDeUpVZQBhG3Kvuupb0uRmmOaVZBwhkBtQxfq66ZZ
	 x7X5aC+3xKIJikkz0RwRRUVetyTtTVkfUUxL0UZsCkH43CsxKU/ILfCYJpwenGvE73asY
	 3zYL9PKloYmIcTT9yRGnFAa5yTZGkOT1tyT1ILy0viomJydoLc/1so1Cn/TttlAstIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D6tEMsDu;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA24606A321
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 12:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BA24606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D6tEMsDu
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b3a332105bso13777177b3.1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 04:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794399958; x=1795004758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6qCUK/k525EVdn9LPhwOUX31G8ImRO+TNKVLJQDtUk=;
        b=D6tEMsDuL9H5dXd+RgjPO6GsrzA3eIu2X2p/sFcDTjAt0vwEKSYO6ZpmKbp7v3oTiL
         vrCjDO9NP21mOoDBXj4o0n3fzntBGY4iM48Qq9hO79swc3d/HE/wBDvM0wJRvtnxHasp
         VVLLLa1oB3sgUi8YQMrqYMmcB4/1KOcJqWURMp8fZQn/dmQ+5beJeAfi87sS5gsFeHXN
         Rg7gbKjhdZsi0gmOE5RYFRCLhGgeV+HHzvPI8tZJuQJaXs6KxViFfINLHkL0FFjNOJ6o
         hKsrm7fdyZhYlwM00c+53fVDA90P+Eg2ZwJWa2UfqCZU1WYA3P9CEptoe33rC/sIxf63
         Cx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794399958; x=1795004758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6qCUK/k525EVdn9LPhwOUX31G8ImRO+TNKVLJQDtUk=;
        b=oZW8WoLy0nlIcv4On82YJvl0e/O3zvIsU4vonKt2MJVP06SWChO+kzRtAImiw69sEC
         vmN7cEauxtWPr0oHuKEqijqt8gQUviXYyYumz8/zrGR2ZyCdADUnsGMYr+ftXdwrugdX
         riuYNgDywqUWfYGOIoEUOJ9HEQMK4SD47F4+zvs7N8h0ugj/DC2C0TxAAKudKUcQEGbw
         lQ8gGJzZjb339sWnPwYtqVv2jfZ4Z+eFTkbRnnrIS57cm5Ner0V/qjSyTbP7WfJ7N750
         B3y0GURvzPyWBn7wnTfqhzyS7YE6z1jATt3WX+BZqb//6qIOwPC/Viu1NPsWz2VI2xcq
         l3aQ==
X-Forwarded-Encrypted: i=1; AL+hErFIPK/UMi+uzfGWw8tZBSn1YP4/XCWwOW29ATy/VmKOUuv7N1ROD4KsiBRYMK7I8W+VOIY9PaSV33o9oQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+9rbdrSX/twFD41Pg91vww3O+HEPZy64Wohuvka0IyjYILL3rU
	FqfQju1QwAamPUpliYgf1dDF3rJQGAsGXw7EfS0jCuMM1s+oPudxmaYS
X-Gm-Gg: AYBFou31w7LnM/O4H2uN03WgOqw5L4SfA4GDR0j7jBL4cZj3Ed21QiKmjkid/czdO8Y
	VelHw/gElkXz3BIN1ZYvD5d06TbP6y97hWT3nbuEKTYjDdqJa1L1oTvIbH1WcmNp+f9O7eRK0Re
	Ex37PH+7JTBKaQj2req6ZF1p6cqrd82IWQSqo9SGJRUGEf0eSfk+xf8U6xQFd3Cz1UFPhgZLHSv
	xhLyt3iQy62lr67d6FquM5+JU4mrlp/9h5aREWN4AXXdraHZRdNKIXPluKB6R8BsfvvK3AXJec6
	ggyw80Z/XeseNmRRuWHwKSp5nHyKP+QoOTqhyQrqOB6uuzvRoqgYIg/hOE2sBpD8UbPp6d6mJuZ
	tjz4IZb1Kz3+CHNd24KirPjQnkmj8mX8LdpVhb4QA9JOk8uIUgIGMY/tuArR85AN7mU28MUgtIc
	rOYsH6ttumdKzuNd6NoqElnxmCPU8QLdPo0wXi2OMz8CYHNpRI55pNHjLDaBc84klUGTM/KmK2L
	ynSgc6fhp51481NYdesuF1ihP4izOn2mlCTJz95GAlm11WC1eMcmdKtNvTLUHFdX8otQxSHrqOl
	hdMtG6RthWJtuyns9ErolupYi5HOHnnl2Q8z7rmS9N0W4pDnA2gIxK+3cGf5Ol3mgbbJhI/bQo1
	xZr2WPxev
X-Received: by 2002:a05:690c:ec3:b0:88b:6ad8:48cc with SMTP id 00721157ae682-8b3a757869bmr21103107b3.16.1794399958528;
        Wed, 11 Nov 2026 04:25:58 -0800 (PST)
Received: from fedora ([187.120.157.132])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39340e374sm42996037b3.28.2026.11.11.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:25:58 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: timo.joannin@gmail.com
Cc: axboe@kernel.dk,
	bvanassche@acm.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com,
	trintaeoitogc@gmail.com
Subject: Re: [PATCH] nbd: fix circular lock dependency
Date: Wed, 11 Nov 2026 09:25:45 -0300
Message-ID: <20261111122545.225934-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261111112921.306969-1-timo.joannin@gmail.com>
References: <20261111112921.306969-1-timo.joannin@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Timo Joannin <timo.joannin@gmail.com> wrote:
> > Moving nbd_get_socket() makes this patch much larger than necessary,
> > which makes reviewing and backporting it harder. Adding a single
> > nbd_reclassify_socket(sock) call in nbd_genl_reconnect_sock_cb() right
> > after the nbd_get_socket() call is sufficient. 
> 
> Hi Guilherme and Bart,
> 
> Thanks for working on this! I'm currently fixing a possible deadlock
> in wg_ratelimiter_uninit 
> (Reported-by: syzbot+72fceb8393e04ce876d9@syzkaller.appspotmail.com)
> involving cpu_hotplug_lock and slab_mutex.
> 
> My one syzbot test failed because of this lockdep
> false positive that this patch addresses. I applied Bart's suggested 1-line
> fix locally, and will see if it resolves the false positive.
> I will be submitting my cpu_hotplug_lock fix separately.
> I am looking forward to see your v2!
> 
Cool, thanks
