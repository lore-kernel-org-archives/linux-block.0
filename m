Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15B1A8F84
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763123575; cv=none; b=K4KgvwJczsrypCMNJ/tFFPEoTtvxRBp9t3SDNgVW8CypNloT61c1nMutR7UwvX4u/OhUnLM74cwVua2HvE5PUPQLk5WjKdYxeFepeQPvy8B6/VRjTVLYt2CCWt30sQWdaMvhn2Osu4ikg6Hn7nwL7YNadM7GJQMVc7adBQut1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763123575; c=relaxed/simple;
	bh=j2DTEN+q6rExgpSX0ZvCHj+92wEnbJMb0wyhQvW3edo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lsJwSLk2qKoTCl8J3dHeNSF75rWvuO2KQtqpBUIFwKP62JgIXHDkgUffv/yse48YivlG4oCeukQvwOgPIsp0GcMGVeBYbUa+Yp4jVTp0pmC+A97lp7VgL8xhj02rNJQR2JRd/IP7LCfEhCITg55MuIcA+ammJ30RidRa1IxbNxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MUMoOhX9; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MUMoOhX9"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso8560975ab.0
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 04:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763123572; x=1763728372; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+DvBoia5YaCRSzy0UQ+Uj7LAWlNRV6szM940avo8z4=;
        b=MUMoOhX9zKtyKGkHMK7H1PsGNtIER4tMHeL8NXF/rv5letlidRMpq6APNXphu6OZYV
         eAgyKG0D9GFmOr0HjUKPdi7z9M2IzffjKhU/lTTbwgVIFmAZJLmnaT/N70nYd3Qm7ly5
         fjPe/oqghK0DVXvIFWn42Ph0YLb5RBy+++H67Bk0l9PUqulkrTzlIAhlG1Go0mAnMzan
         hCk4qXwPzd+PSgYJG//pAW2BauEtoasMNk91AqXv/PBqp/bAYG1Kk/4h4dkLhvtHhHUh
         lv9ZlAY6xRpg9Hj+60Jeh5x5BZSBbYRyJb0lCkx+lSokzTf4FsSFIPf1Ef6c2sDPh7Pm
         zXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763123572; x=1763728372;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+DvBoia5YaCRSzy0UQ+Uj7LAWlNRV6szM940avo8z4=;
        b=UZy2Cx/l/R4L7E13vMmHkRqY5m2cDhfbwMYQnnc6jEg+PI5PFf6eQeiN1CcMYGSOuI
         PJNyYo2dt7qq/VWNLEa6Jjw+HHmyrgDw4FFlsAe08i8wIq1Pb+e5O8dk7hKXE5EBxJ83
         znplwZYu03MdRfzVXE+xyzFrJm6LfQ0VWixKe/7hsiqDzT721PZ8KhveWJWoD4PCEhjW
         2Id0dm/2GQH87zc50eM5ksoglSZpLs4LQR2L8maYqz72ofWAKhzaTvS2e5ZJGLCk9Ds2
         FcwHCle5imc1y6XGlAJkeb+EcxUIephuWaINKHyrzNDmlesOxKhuN22nbG7kkdaBr6rF
         0eWg==
X-Gm-Message-State: AOJu0YyOnep2t2s+z9omRIfmkUYdltu0sdTW5Gv3Sa4SmEVzk+Qma0Kc
	RSgJ078quPSTz5Yo5S/tILaZKn8F6IMvebGNJn5NGa7Ob02TaqWj7H55LI10Ry7DZSw6L84j/tO
	RR0dm
X-Gm-Gg: ASbGncusIV0wJovdCLZyd+l4BQ9cV0l5MlDRicGkhigPbN9a2NpoltTaoyN/BszohQ+
	grq6NuMat9e2PlqlRcJl6SWj9weHi59gYkNvY+XuzRP+qp9bdQkwQxKYFTETdx2W9fame05qI+D
	tr3akSPaauV6D+3Nzz+Ik2ffIPGatYzHtIbunsq99nnXtyEsakzrCRZBj9XrhRPKfFU6iJ0gcsj
	Q6FVCdwVaL0uRN7eqFBtekqTrOOg21OMN4OXX9hl7BZYbcH6xHINW/q9noPzJQzS6jewqoQKdb2
	2Bpa0Y34Ih7FTo26xNXWKqbkzhO4eG5VsTz/AHOhE6/bfJejUed5JuLpY8eyVzSvmp5PSdf9A7K
	aH17J9yvb4eJwQN56YD7kbQqepZaCjTnA6r1mDD41LHJupgup6SPx7ih4AoS66Qb8PXp+gcAUJx
	f2u92D9YO0
X-Google-Smtp-Source: AGHT+IHY9ygHHg1+2edJWlyJ6bVUbi0JzgizxxcLteZasSIkbrZ7wQVHH3uDfH2PB3GJxKuzOjyTGA==
X-Received: by 2002:a05:6e02:1986:b0:433:46fa:6a7a with SMTP id e9e14a558f8ab-4348c91c18cmr38748265ab.25.1763123571801;
        Fri, 14 Nov 2025 04:32:51 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839cdbe8sm22977205ab.31.2025.11.14.04.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 04:32:51 -0800 (PST)
Message-ID: <84cc4f70-9746-47bb-a606-0fd71b01332d@kernel.dk>
Date: Fri, 14 Nov 2025 05:32:49 -0700
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
Subject: [GIT PULL] Block tree update
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Been sitting on this one for a week or two, planning on sending it out
when there were other block changes for 6.18. But as that hasn't
materialized in the second week of sitting on it, let's flush it out.

A previous commit updated my git tree locations, but one was missed as
it was already set to the git.kernel.org one. As the git location swap
also renamed the actual tree from linux-block to just linux, let's get
that last one updated too.

Please pull!


The following changes since commit 0d92a3eaa6726e64a18db74ece806c2c021aaac3:

  null_blk: set dma alignment to logical block size (2025-10-31 09:03:12 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251114

for you to fetch changes up to 8f05967b022d255412640670915475ac4cdc10e9:

  MAINTAINERS: correct git location for block layer tree (2025-11-03 08:55:12 -0700)

----------------------------------------------------------------
block-6.18-20251114

----------------------------------------------------------------
Jens Axboe (1):
      MAINTAINERS: correct git location for block layer tree

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

