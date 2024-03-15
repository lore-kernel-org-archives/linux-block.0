Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69238DD1
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528920; cv=none; b=kBZSnzHgLU3lrfLPC1wv4dB41AiI5W3/O90JbH/r8rwRB5CZCd8KkD9w1nROSIPUmK7tCeixpEE7i8m35ozNlZkMrKZ4a8rrh4IFYAxQq261R7ymZyAdBRICPzNAvYkclvasE8BBlShxoK/7VQ8QhVYossAGkH7z7m9f44whL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528920; c=relaxed/simple;
	bh=5l2DsbuHQaizghK7BFt2Nv04PeEJ3f3oDWJrl5UEJO4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OJZOI6J0kEeOjyfktIzbDjkOhC6SC6bfpe/y8Zc3JvL9xtmwiHMlVImbxG27udYD2bVNlfdtlJZi7tt9jf8QAQATcx4x+47XVB72N89LG/wqzXEokMpFpNVuTLVvn5fSSVlNLN+mdHhgCLl29pRaZBkS4xJtZXd/E0ubvTJI7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jmeK5ypR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jmeK5ypR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29d51cdde7eso671442a91.0
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710528916; x=1711133716; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORtMChK1dM5bEirIl3afhpoV1LzkhXnlNBlXIKlewQU=;
        b=jmeK5ypR8TFKjUtJJlFKZS+u0by9HtCuBtszqCUDPZiLhrqFACsrkSnJ0pxGVpKJl6
         kNalo3Ph0/RQEJXIYcacGim5Cqi5RxJsmcwWbte+kLj94Z+jfnffJp+emi4QPfZ7P5Td
         yV/kVrGUpxQ9ouzj4HuW63x1vTtA2Tr2/cBJUYLcfm/Me6tPTIIAN3cqtzx2hxMmphwV
         n21W8ZNuRXafczvVW5FZIWqLoN5WPceP2cERvhkPO7Y+2fIa7emh3Uy59peeoOE6S0rA
         hcu/d7V1gJm+mG+/kShNUlIPAHnZKQojMO3JFv5Bw6+1ob6B6bx0Rh5V9DZl7So7gKR7
         v9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528916; x=1711133716;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ORtMChK1dM5bEirIl3afhpoV1LzkhXnlNBlXIKlewQU=;
        b=nIg1E99C9nhvXU2wn29ePu0wtQSUPQsGcO9QImC5TP6rZkGcUKJrgF0Kl8NQozmFfl
         BxgxuFv34FzPXoQY1DDepLJ3/Bq92h5B6//NWKlXACzd/rAcsKda6xVI1jCaLv89mG4e
         NFhmodKcySt20mbliSW8c0VflTYI0a0NOYM80cvzAvmNJbIr2NKbane/bahPdWnu3T0P
         DEKzJROsJy8jekIqUfqjBLMv8p4XvJzLkEXHlTqecSIJgfdHSb1HpnSuXDSFa3F7wfi6
         YZOmppznlskpsu6XaxfGzBuWfGKBIAvJLZJzxofYhzVFyL0LyDmA7f4MsBgP8v5JQWje
         tWjw==
X-Gm-Message-State: AOJu0Yz9qPRqSNXrawmEvgZtzT20mDkS/JKl+dsLu8OrSP1zo1PR9DlJ
	PyCOFIavTLDjTTERh2yhJuOghsMg9Ampoq8uw2Do588FLkryAhtxuvlkFuAOVi33AIWbou41olw
	Q
X-Google-Smtp-Source: AGHT+IE3D8Q4cRPoPRWU8g+Jwn17ssVqKeY9BnQB8u0hZgOMd6mXsXxSfQUs0vWXricTOujUkTodHw==
X-Received: by 2002:a05:6a00:23c6:b0:6e6:8b98:721f with SMTP id g6-20020a056a0023c600b006e68b98721fmr6360822pfc.1.1710528914821;
        Fri, 15 Mar 2024 11:55:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a00181e00b006e6c88d7690sm3726123pfa.160.2024.03.15.11.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 11:55:14 -0700 (PDT)
Message-ID: <83595457-f418-4aab-a578-274a78817d44@kernel.dk>
Date: Fri, 15 Mar 2024 12:55:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.9-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Usually send one later towards the end of week 2 of the merge window,
but since the timestamp caching fix didn't get pulled up directly, and
since there's a few other fixes that should go in sooner rather than
later, sending this one now.

A few fixes for the 6.9 merge window:

- Revert of a change for mq-deadline that went into the 6.8 release,
  causing a performance regression for some (Bart)

- Revert of the interruptible discard handling. This needs more work
  since the ioctl and fs path aren't properly split, and will happen for
  the 6.10 kernel release. For 6.9, do the minimal revert. (Christoph)

- Fix for an issue with the timestamp caching code (me)

- kerneldoc fix (Jiapeng)

Please pull!


The following changes since commit 259f7d5e2baf87fcbb4fabc46526c9c47fed1914:

  Merge tag 'thermal-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2024-03-13 12:03:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.9-20240315

for you to fetch changes up to 4c4ab8ae416350ce817339f239bdaaf351212f15:

  block: fix mismatched kerneldoc function name (2024-03-14 09:40:47 -0600)

----------------------------------------------------------------
block-6.9-20240315

----------------------------------------------------------------
Bart Van Assche (1):
      Revert "block/mq-deadline: use correct way to throttling write requests"

Christoph Hellwig (1):
      Revert "blk-lib: check for kill signal"

Jens Axboe (1):
      block: limit block time caching to in_task() context

Jiapeng Chong (1):
      block: fix mismatched kerneldoc function name

 block/blk-lib.c      | 40 +---------------------------------------
 block/blk-settings.c |  2 +-
 block/blk.h          |  2 +-
 block/mq-deadline.c  |  3 +--
 4 files changed, 4 insertions(+), 43 deletions(-)

-- 
Jens Axboe

