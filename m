Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531F37E2E9
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555717; cv=pass; b=LLrYwue2tLxyIa+UPXPKPoO8fqmZrb/Qe2QiqJw43kBHkUDDfWf/2I0mrbO7elsHZvjXDKHIyD74WM6W+vbL+4gENUL7X7oB84o9lZhtMRtuB55Reg0ZHk168dBkwQNtg56P2lNMY/xxaA42YpgeA8bhZnn8VOWPeFsFe94SJNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555717; c=relaxed/simple;
	bh=30eMmtxo9dZdwlJ3E6z4UwQCm88BiouFKOwsHyXsVEg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TlidADuVNnj57wutKfMU9XC79ScieoQ2DU4piVEJ5MemDRZ8NUC5AL2Lw0Ji6XNx5286F5zUY/C2rfcgXMDGW4Q6SZYpTQOBxcCs9S8aDgA0bDM9O00ZynnfBXcgpAxVW84BCQW5KhI7G/INgWmgrwhiUA5GIqlRJ92a8je07Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY+D3gQr; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY+D3gQr"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b16824c0fcso2301206a12.3
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 07:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791555713; cv=none;
        d=google.com; s=arc-20260327;
        b=S670v8sGdXw/v8m4MBS+m2hjytkMvF9FooW2GIAGd3annlTpYwSzc+MMwc8V/UPoru
         9Kmur6NIf1BV8clj/QCq8a0KIGxffuqio3rw34SALt16OFiHcKzTZnt1IWaUzuiG+IRQ
         Zqq6VzwqcFenYa5jnefXQqc8Lww2my7d4vgzlHl3c/070F35Ooy8dPTpAjTj9QEy/TN/
         mmsWJH88DZt7v+bNLKEo7UZ8ZlQg5AyMy4SU8cm8WR4vG1YEoMZ4smMtUCz/Bu6dubK+
         yrGype1OdQMQ5pjHfQoDXc2Y98dhCXH9t6ksjBS2eeXHOMn0lC46ct9Y1SN0OaIlUbMR
         fYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=R5SiVnaUQQN34hVlYPHW4REpkY55paPFDk59rozrL+o=;
        fh=MU5HNJXXg509sP1LckMOKYPTGn76SDWI4tkGNago4b4=;
        b=K2p8DC4wTILxRt3ayRf5whKgIZRZTWaEKVvjNGqcofDrpF+UONzyV9/Jc09wKXirig
         xYmbSasPSVrd4hLN5ARLYBxlt7aWvg386qCDXjYOZ4+VYO8v9iYbxEmjbBlkhaede27K
         c40SHItBkhoUHeBc7d+g8n2lBbS/ZaGbNKxWhTGpOWbTvkl1V68k9rF2Nh4G1Ev5057s
         qrqoFiYF1OkBY0yV99SOeS8gDQaaJttzTzmW4Q5ZSpFWUF9ulFpMOlmxi+ONgUtb42kT
         5LxxpxqrzT7vA6wXC1V9M5nn6pHjkFYojF3Ozbx2FaEzBkHatkH/mU2hLZZnPWzcfjxd
         MvyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791555713; x=1792160513; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5SiVnaUQQN34hVlYPHW4REpkY55paPFDk59rozrL+o=;
        b=YY+D3gQrC+336SpGwPsxLOFGXQY/22sAb16i0oZXkhbu2hWoMaJiBtQcVQW31RA8oO
         A+tjU04kf6EDmmIfO9bxCQIF6jXwXfYfc4uBt6m98cmnIliyqA2ulBIBVad63AMKI/zY
         6iXZL0moiOvhI/Oo9cZuT0+kZeu+ixziAoeDxzBjT9wvN4Sbw3ka3cXneqvjiIoFPcEG
         Hr/xc0wGHGnofsAlfuhcaZ6t1NYEbTAWp5p+3FdIMEmrX2OPjkna7RI92sXX7PPbW6rU
         7NWR5ImfLBdI725E9B8TOVvyWQ62GSTlViBrgudFX4JcEoTXM1s5aedeoJZ91qzqXIWV
         VXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791555713; x=1792160513;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R5SiVnaUQQN34hVlYPHW4REpkY55paPFDk59rozrL+o=;
        b=bBv8qNL/vvaMLoF809cu9pdvvcBY8ocS7EDti2Xc2LdH3BNNaK6fcHzUchW6jaae55
         D7aZWjRwjqVwYkPSlc+KdBWqUD/VzuEW0T5b3sNQu0UQFhG43P9Kg9PDhlzlC8mGGKaj
         ulU0VkLtDAseTe5bymKv7xRrGNWnFTOiVAnNQDqhH4GljBnh36BFPqAM5+POKwjMs8Yp
         tQ2FbvvwUB6eHeipF3Niy2SQ0yTFxlTm+wEeL8zL2ttFY+ySVt6wjqxf5yukM2NvfWmu
         Xv5AKSR5eR0pMeagFYSYn0qI5C2NJ0BoD0Cl8aYL68hHRXmUTGwnKdZ64eVihCzHYO6t
         tagw==
X-Forwarded-Encrypted: i=1; AKwUvBwnaO7rcUY5ppBJ/KScSPhCtvDEmQG/a0zkzFJDfvwNm6OBKkFhUWQ80+32yeJ6KAVzByNARNQSgV29zw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/ix1ZM5H2IOuzxPuruDGr7tnQAKP+1A+pIvVI/qE5rIevju/M
	xfqtE0i8dUZNU0I/s6J5QnxaOmM71PwlRhgSmGnmCajLIvaciWA4TDKCfj8ulRViFe9NGE3brp+
	wr0iacMgRbTN+jUWLZi3vpPtlWt6qba0=
X-Gm-Gg: AYBFou1Ll0jnudzt9pRavURf6StyL7n110qDUY9eQMZL9am8UNrtZb92zA6tWQBQeBJ
	6wtdXf9aoxpuPeq15yYwPvb0dOzGXJubqaXSlJ9ngH28G1jdaAdSDJY+iV7t1ILjrxpnWYiB5cm
	4c660aI3VbexfhcXV05mN17TLroP20bRpXP0kbYAbDi+xHRuOS9Gvk+hY6UAv+8oMr8CptLBOBc
	SawVOu3/YSILadcMCpbUr0G4my2jSEnTVCXP/PdSQYgk6Gpfa2FTSprcq1euxK8kQQfE2aY3UPO
	LlzHYLK6nsEPX8UUGe/yoxzB7b08D9kIY/PQN6/Dlat/gtApsBUEl2Uo7MsRZQdl/rjHJox7
X-Received: by 2002:a05:6402:254e:b0:6aa:b39e:f794 with SMTP id
 4fb4d7f45d1cf-6b17c28fedemr1748598a12.42.1791555712392; Fri, 09 Oct 2026
 07:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Leitner-Ankerl <martin.ankerl@gmail.com>
Date: Fri, 9 Oct 2026 16:21:40 +0200
X-Gm-Features: AclHuK-62QwvTT56LJQI5jAhTvpHHwM53Qctdf4WmrpYFSOHVx_FT6G7Rry0i7g
Message-ID: <CAAFOosa2WLf--T17cujJu5CUsN12NNjgTitOvno2LY7jAr1gfw@mail.gmail.com>
Subject: [RFC] seqlz: a compressor for zram, between lz4 and zstd
To: Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sergey, Minchan,

I wrote a compressor only for zram's pages, as a personal project of
mine. Before I send patches I'd like to know if you would consider a new
algorithm for zram at all. Much of the code was written with an AI
coding assistant, with me deciding the design and checking the results.

seqlz stores pages almost as small as zstd and swaps them in close to
lz4. On a Xiaomi Mi 9T with its own Linux 4.14, seqlz as a module,
20 000 pages from the phone's zram, the whole page fault per page:

          bytes/page   swap-in warm, A76 / A55   swap-out, A76 / A55
  lz4        1300          5.3 / 16.2 us        10.3 /  31.2 us
  lzo        1216          6.4 / 17.4           11.2 /  33.9
  zstd 3      898         16.9 / 47.5           34.7 / 133
  seqlz       935          6.0 / 17.9           12.4 /  38.8

So 28% fewer bytes than lz4 and 4% more than zstd. Swap-in is 11% to
13% slower than lz4 warm and 17% to 25% cold, swap-out 20% to 24%
slower. With 25 apps launched in turn, 1.5 GiB locked away and the same
disksize for all, seqlz had 3 cold launches in 3 runs, lz4 24 and zstd
6. With the disksize scaled so that each algorithm gets the same RAM,
lz4 had 54 cold launches in 3 runs and seqlz none.

It is LZ with Huffman coding, but with static tables that are part of
the format, so a page carries no tables. It needs less work memory per
CPU than lz4. The format is written down, and a second decoder written
from that description alone was fuzzed against the real one for over a
billion inputs without a difference.

The backend works on your series of 5th October, "zram: redesign zcomp
and rework backends", applied to mm-unstable at fb0fbeb37, and on
mainline without it (986c24e0fe44). Under KASAN and lockdep it swapped
12.7 million pages on the tree with your series, and 34.9 million on
mainline with UBSan too, preempt=full and lazy, no report and no page
that came back different. The zram selftests pass, and there are KUnit
tests.

What I don't know yet: the phone numbers are from 4.14 only, I have no
rooted phone with a current kernel. With 16 KiB pages seqlz needs more
work memory per CPU than lz4.

My questions:

1. Would you consider a new algorithm for zram, next to lz4, lzo-rle
   and zstd?
2. You wrote in March that zcomp will move to the acomp API [1], and
   your series of October reworks zcomp instead. Should seqlz come as a
   zram backend on top of that series, or as an acomp algorithm?
3. What would you want to see measured to decide?

The code, the format and all measurements are at
https://github.com/martinus/quetschn

Thanks,
Martin

[1] https://lore.kernel.org/r/aa9tz-EIh7kOF3RM@google.com
