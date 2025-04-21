Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9A1E990E
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260205; cv=none; b=u5aAz7noJQBo7+sDKCVOuY1qNFQu64iVdtjuuIoBc9DCmicE3/XQsFSpc/BdV1tjfaJiOqBuC4PKJ+YQgjCrlOLvQcZCUyqzO+yhOX4d4Ugb0FuiBh/JhpKO/PVnnkgNGsuA1D5xdg/1RxDrUOUW4EE7xM3qHf6mc5eaTJU+sDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260205; c=relaxed/simple;
	bh=jCdOVNRAWAR9DqJFWEEs04l5X11ER7Or5ifEH0NF0vQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=swPaoJ57oJORsnHgCWI4N/mpE4RrpraupuM/uZEOYCZqCCLWcLS9PohWYvdFo5ufU4oX34s/wqUaGofpCTxZkHchxDH/QnhtpsyjsH1M25QUJ5Rz0cdXfe8aiaxJifgiyJIEh+vXdPFJDTSn5Ad0uJBbZmdZDakdAbRTb/vM8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G156DrdZ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G156DrdZ"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b3f92c866so63846539f.3
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745260201; x=1745865001; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGkg6fJfEeqQsskmUDXVrcnD2zKVMxuHFOsr406hQA0=;
        b=G156DrdZtaYM/Y+a5/XnVZP4hvSxrhjB+tSS4+82b/OFeW1NxMJhJDhSVNVKb7c+L8
         oY/2NKPkvPjX50Ll4UUgnju7y5NQvV0nUMS4cexa1biONZXZmHlWhmGz9INadAz90k1u
         x+gfr+9qNs7oYT9sxn4bp8at0EVTUQhjzV3M4g0ek5qKDImlNdZXZ7oH9KkKZJG54Txl
         caOyjiTiNSUxC+/aNjyBv+sq0WMrbZa21PBW0c2f4SdoXad6jqMRVedAHp8c9DhJ6alf
         TX3qtp8KZ1emhJy6nvEEbA4WuajOOC+yDvpd95LYrD+L1MKJmCj7TID84A+o31Pa05ah
         SDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745260201; x=1745865001;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vGkg6fJfEeqQsskmUDXVrcnD2zKVMxuHFOsr406hQA0=;
        b=d9LWlkjZRAM9EcIaL/2nACMgPWIgTzOSSYPz5eUj7Qcj9L0yvevqAd5DR5zpspnwA/
         Nd0iAWP/vIUzFcbg7ZsJWD+gNzd5CAs2zIuPIpgQrexk9Zjyz/Z13UfajbbAfjLwElyK
         blfmbg1DVZpM5qs8t/cqJXDlyp3lJ6jJQ+cgErEPbAXPZtLK3KEsIPC6dHfMbnoE+7we
         POndcAsDViWclZwyfWlruCJlrnKpXzBfvUfsb0yr705yyx3/b23aThVLZEWkhXQgGn9u
         paoH4/2Sn3BZ2pvJ6wWOkHM3kvV+dTNq/QwdHBZIusMDboI+eKuJvT4P7KkrjTY0mz9o
         QFqw==
X-Gm-Message-State: AOJu0YzHYWlunXXic0mBQjCnB0xQ6uaGqsyPqKoQ42VvKqvIfrkLDwJB
	ZVCibQ4qfD0qV4fu2nBwyWWaYc4z0QPMGWBspY/0HB7RRI9YmqJChdaLzbfb0lXiOuc/3h4WtO9
	Y
X-Gm-Gg: ASbGncuDO94qS3wJrbbEBKleUtSicWSHW2IGQmJ85OjeNPgWRk9k37HmMy8PQHwFvWY
	djVVh99nsAIk5alX7wjzxAcsUhhBjqmulZS8tScuH4crFOH+x57S+rfuGJOUUWza7J5IxQXlI9u
	wp+tP/V8bgx/D4SY7HlQu6QKs8rP2EviY/SvCWw6wY0UZ9zowdAv7O2AjeIg0v+ounAmqbYh2Tt
	xY04YXy57ZRSuOgyLLaaKGI8WsPYLH68DeO8OS5ALXdvwsfOpLKSvLbQnlqEaeu6Xp3cpoUiC9L
	4/SifPm+P9zeoA763iI8k/JAcwesokiQBSBezX1gnNUklag=
X-Google-Smtp-Source: AGHT+IGs+RY6yuQIDSZ+7ZuvnOYwO/eV79WXKG2RfxjH69TJj3I/337jZDquAm7a3dq3yNkCxgc1lw==
X-Received: by 2002:a05:6602:7216:b0:85b:3407:c8c with SMTP id ca18e2360f4ac-861dbe93745mr1237803239f.11.1745260201114;
        Mon, 21 Apr 2025 11:30:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861d96129aasm179946339f.23.2025.04.21.11.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 11:30:00 -0700 (PDT)
Message-ID: <b858ce52-212e-4913-963b-07fcead96f30@kernel.dk>
Date: Mon, 21 Apr 2025 12:29:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: for-6.16/block rebased
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Just a heads-up that I rebased the 6.16 tree this morning, as there's
been a good amount of changes flowing into the 6.15-rc tree. If you have
a tree that is based on the block tree, and you already started it for
the 6.16 series, please rebase as well. It's early enough that I didn't
think this would be much of a concern.

-- 
Jens Axboe

