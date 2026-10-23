Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792779562;
	b=niWJxrc7RvTKg3C04FPUhWTH9aUDzMx8v6SGdrhUA7GpCg0KPlaZ8V7qnZikvRKOPZcV
	 GjiYFRa8Ra/6FQE84z0IOIqh3TL9eIqa9OVrxJ5o+X/HwOkzDOCIqeovHYEZrdhyefJPS
	 oE/fecyz+9MbMLjN4JI+cSfbl6zfKc7hzIglQJmhZTtt10jM6dsWYMJ4QBoEj81ziWTZS
	 Ucmgr3M6tSCxGbT+AbbFne8yVVoFyhzaWWjwmLQSJQYog29ZZn+4lL3opRc0AmYy9Xg8S
	 Arx0iiKuQFl89sdTTPL55mlf7wclZS1PfFFqs4tFx6KA65XI0zM4NRbVGNX4CQxDpQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Sf63KFDDNNQERzVahv0eOgq9vdaVcq8l5ll+ubDdbTA=;
	b=yJKHtD8GHSbhXtoD0LvhgucCHjF64Js3t11fjFnMUk8v63YORjmVaORZVAAHQYj7i4ij
	 bQM+/ZOSs8IwNaNTv+GROSz66SFhzTcp1FcgGavMNHwaPYALtWYrVcP1K07uJO4YatrnI
	 1m+vy1XqpO6cXRhn2Rv0UTXZDws469VSBkdjKbVF49ttOoRMoA05SBQy16a/ahfZ+McXs
	 PybDlgjC+mVo3mSFJ2hNw5PsIkPWbRcfUpTZrabmJqM/bnyhXWmNAaHdE0hnxlAvhwDtM
	 remR50/zQ2wy9pUb/jQNsI5tLarBJXWOVHEC3rbxH7E3iFNnwMIo5vFIpi3/q00QOfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BBDe59so;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB9606A31A
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 18:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FBB9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BBDe59so
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso750770f8f.2
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 11:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792779560; cv=none;
        d=google.com; s=arc-20260327;
        b=a6IA6f/J3Q3Z1aZkIdYXxHciD5jyPRtRr0qFodvQtTxL0E1SwElcYSLczDqV/B0mvt
         OOAIcRFB8GfQS4/65hHHG3Cqnh4jhbuQGo4BDEQlaOsS41gQ1mq4aMaYJ4qqJxWCCW1S
         7LYXfbZxnNyDF35hwj6PQnk2GRJLMddU3RpgkeKTjDX+Cu/2KM8bu3PHjo02wN0ynNr7
         lgrnbPsZiSFzCxYDWFJK4/W/4IhfNjvscORz/3YluYTW/bmaRfCFnPmSp1I3zppsk5fx
         aU27idR6/MwJC8T8KQothgjkGJmdWMCCx9yR1e4yjUunzPusdJxDG08ES4mQ9fvqSStv
         oYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sf63KFDDNNQERzVahv0eOgq9vdaVcq8l5ll+ubDdbTA=;
        fh=QSXsVnBBdZy7Tv9v/ejzQV7Bm8N5aBX3etpRvnQ6C1M=;
        b=LEGffHwYD/IQ3QNTFVoMLKN5LS0VsHZpCuqtiBMkP3hLVkWLGMl6YzwORNmMfCVy4v
         Kx0/KlMocUC69B8Kl33Qvz78xcG5xJb6Uh2JLElCcHhZSDRjRtJQf+ubTD9/MBktEMiA
         W3v8kaTqISLUx0tlzzt45FLbB8ER+AadzqzMR9QjzJO4W5MUPXjlhiSkZ6UO1xsNnSLo
         03UqTCgjuWIFet0PipbaiYcIwE74KM4NQwzObUHSxMhLro8mvYNUNeAkZKWHQ9LJUUdc
         eSNR5UOmbLLLZTmxGGU18kIAh8YXe2I8A5lAPW4DCwea9Td4omQQblzOFE23OExaIrxB
         QorA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792779560; x=1793384360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sf63KFDDNNQERzVahv0eOgq9vdaVcq8l5ll+ubDdbTA=;
        b=BBDe59sorH3ey9ncvQ8jxLzMaypcvb9JmpozFNmxG+0UhPkZxLLRrMEJP20fzxpkGD
         qZoKsXRemYlyRqaHAHur/TLtEsnaYJs3FQH9/dFlpU49ktIUx2el7C0xwTlKfA/HbwpQ
         1yfH8XqLvKpnH/zNGjvyTaSQcAWCdy+NoPdFI/vttof0uje/KCUqhmJr1Pm8a0Pq8P+Q
         4Llr5QB5O4hx+q5fLA+Rmws34llicN8FlbeCu3vU8CqsNkU+NPGF5GIHhGjOulcEoJQG
         dCu1xjV2umDDfNfM0w4DHSh4WdMK1ljoaeDCGprHns+5WGMymEqCDl4AuqQfCPdIqXYB
         G1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779560; x=1793384360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sf63KFDDNNQERzVahv0eOgq9vdaVcq8l5ll+ubDdbTA=;
        b=Wq+v1JTEpBzYT6fN/CUpjIyBAi6Rxc1wcu+3sUKp5h6lyCxCaqRuiVN1U4z3d1CVR8
         0M/2gPISyFr+3X920/EFK1OYGogAH3QJnfdr34KBS3VyHO5lP36PfN9Ckgwa/SF5BeFp
         PQZXkeUskK0Bis8uxcbAtVA6lpNI/Qb2D4oqL7+Qz05rdm98Ulo3J23PB1eit8s9tsmA
         ZxaxrOuslN0bcKCDGkYmdkGOHMO1qh8oG67PZp72RrnX34A0K1WTLVju8Cb9koR/Oycu
         7llkoWJEyt5Pwu8LRN8pKeYvqm/I6S+Eb5eRNGVfhG+g+sABgR+4GQzVSRuQSv7o3QTx
         4RXA==
X-Forwarded-Encrypted: i=1; AKwUvBxSI78fDBOR4SDWeh5PQMwHL1q32Km6l0t/KxD264ExolpGnPP0691uId1MZNlNu5QWkeIeLBsyICWYbA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLirEaY/ZlxlymsH1vELfgGr6/wXdqrjaZ3c8kfr3RyEUsryaEQ
	f+xDv6zYJvjS9BEZjaZ0jgBEezTh0KuocS3xsoALxWlhjQZdEfcxZB0VaxX/oxCZKvj0RCgloc8
	p2vs0M1+wtEBCNpdb9eLdjlFu9wSFUTY=
X-Gm-Gg: AYBFou3D/EKTZFCSBy3fwc5Ipd2XqsqwbTf1+M/luy5Y427Grq4XV9vE1YgyenaQIOa
	a6nKDQ3fruMm+of7mjH5kRhJCRN1Rb2W+I+eS0ilUYwbx0/inpdjq21AYe8wPBHgIfLSnbtNeuC
	Zx1HvE/F9tRN5YIfooZnf9YuVPNA+2Lw89w5fKCNkpHkPq8mNbcET5HdFjF5TeSGfD5bbEN11zB
	Hbshi3rTK+khhE0gDYTQUebCZpfS6XpBvTpCr7tqxR7yjcll65Gqmc/ocUEcHzMllOzVNmzI7E7
	aDaVKbxJ2/YSVPDmv47fMIEcoApv+jm85w4nDmEdMB/C1wusllu3tcM5p2VgJB6kRXtvcHyjN9K
	9Qvu/BwLdonhDh4n8fvuuo8lhAJOZwvSYgFQ2xrqNIR9/FSanHDhFVNZbgZYDetwBnsaNyk80eG
	0FdyjLjmKKNf3VYXaek2Dp3ZBHBdsdVdfjqq65KEsxCtE4gAafQft7
X-Received: by 2002:a05:6000:26d1:b0:48c:4444:f0a2 with SMTP id
 ffacd0b85a97d-48e38546c63mr4724859f8f.7.1792779559823; Fri, 23 Oct 2026
 11:19:19 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
 <CAKEwX=ONniSwdiZAe_8NT5XwVj=Mmc-WJs_rWE4Y5snjFg2=Eg@mail.gmail.com> <20261023123736.1542117-1-chenhongfeng0212@163.com>
In-Reply-To: <20261023123736.1542117-1-chenhongfeng0212@163.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 23 Oct 2026 11:19:08 -0700
X-Gm-Features: AclHuK8IXUKXOT1G5BawvIMJ1TanzNZCOYP2ZLn7pIObqIp0SWbrNFngRQ39xBY
Message-ID: <CAKEwX=M4jTnxmq6cj115Gw4u5jdY7Ex65jPtVTEopW70jGzfuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] mm/zsmalloc: defer object free to per-cpu batches
To: Hongfeng Chen <chenhongfeng0212@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, 
	Wenchao Hao <haowenchao@xiaomi.com>, Wenchao Hao <haowenchao22@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Hongfeng Chen <hongfengchen@xiaomi.com>, Hongfeng Chen <chenhongfeng0212@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:39=E2=80=AFAM Hongfeng Chen <chenhongfeng0212@163=
.com> wrote:
>
> Hi Nhat,
>
> On Fri, Oct 16, 2026 at 9:09 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > 1. Would memory freeing be slowed down?
>
> I sampled pool->pages_allocated every 1 ms, and measured the time from
> the start of munmap() until the zspages are freed. Three cases are
> tested: 1 process x 256MB, 1 process x 1024MB, and 4 processes x
> 256MB. The results are as follows:
>
>   workload                  base      with-patch
>   1 process, 256 MB         14 ms     9 ms
>   1 process, 1024 MB        51 ms     31 ms
>   4 processes, 256 MB       45 ms     24 ms
>
> Memory freeing didn't get slower and it actually got faster.

Neat! Thanks for double checking! I assume this is because we're doing
memory reclamation in parallel with the extra kworker thread?

Which brings me to the next point:

>
> > 2. Would this introduce isolation issues, especially when this work is
> > not properly accounted?
>
> Yes. The drain runs in an unbound kworker in the root cgroup, so its
> cost is not charged to the killed tenant, and it may take CPU time
> from other tenants. I'd appreciate any suggestions on a clean way to
> handle this.

I don't have a good solution either... This has been a blocker for
other work offloading idea too.

+Shakeel, who might have some ideas on this.

But before we do this:

>
> > Another thing I wonder is, how much of this slowed down is because of
> > zsmalloc's own inefficiency, and how much is because we just have a
> > larger logical footprint
>
> Mostly zsmalloc. I kept the footprint the same (1 GB paged out to zram,
> then munmap()) and only made zs_free() do nothing:

Is there any more juice we can squeeze from zsmalloc in that case?

It would be nice if you can perf zsmalloc freeing. And yeah, maybe we
can't optimize any further, but let's eliminate that first before we
rely on offloading.
