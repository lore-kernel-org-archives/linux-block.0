Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486514E2E2
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259625; cv=none; b=GvZMfB7rWl83UmR2eZFxVC8cjwLrNJiekxsp8VfQWF2SThu/vM27ZZm84bQTAlI5cnWnNlS4WGzpmU53GyI0XETJFTYOYzdqvkovDFWKFoEmssKHLg9IdUJahut+MFNG5Z0wHlElOFoL31g8xZ2PR7g9Ko9F1M+ABXaWAY8gZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259625; c=relaxed/simple;
	bh=PVG/u/rBRJtGXc7icffonY7sSvjL0w8UC+NsDC4RqhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=rWtxHEtmwGsw3adVy+84GB0EomyUgD4vAlJSO0uCIjCN8IKfoSZ3OP2QWXSUKwYRP0okdBNK5RH5NMT3VzwhbZx3UqfjzfGb3nzzdc7h8HFJv7ikHePmSA9sTdCy8QrqSx5I6yqZj+IPDV0Ixn5s7o5HJU996lV31ogrP2KNcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV7J1MhR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV7J1MhR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-294df925292so49515775ad.1
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 04:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762259623; x=1762864423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRHHdJQM2gcBeM06136CQSgxSJ3eclLtWip34bcWYH4=;
        b=gV7J1MhRmn62F5zM9AFF5163CxrhGjqCIvlisytWIbGoMhUdo8L0WHCJCAEjTHNKJR
         wdtLGJdQJLDRGL4uTiaZsH5OIkBE04KlizY5y8mb81o5v5J/HJb1GgvCyhspkzhXO0Ko
         HLlYZBNyOWNyC8EKfQQhdsvolw1Vq6AePzTCIT34DnRkVR9ZQT090KCtGTTceC19x8M1
         amUhZ7PwnGdaQtpe5AO6A+XqSKZY09RGwRPrfQB4fuMc6wXkh1jlmywVMwwE3ZWTtBaf
         oZ/8Lz0QDKwWIhkzPvrv7njY08lt+GNV2k2xHxqeAgt0aqS4c6qOqR/hx/mHhYfeztu3
         dsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259623; x=1762864423;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iRHHdJQM2gcBeM06136CQSgxSJ3eclLtWip34bcWYH4=;
        b=OKUyOyjjUGIej4BfWevrENFTwBJ0qBNEjYMSk2KrgE+NBHyxXmw5wp2RHBcfmhstll
         /hjAagc92j1xT3R0yyszc0gTmWptsMbwjknkE6i37MIo5vFzk+HB7PYsfsb2Ll0oOhgM
         EbgAYDs8AaipVwBSFp3SRzC6KN2U9DH9jHx0iNWq6RiOoubMkXl/dC5W9ZBrHZvpXGbm
         jqX0ZjKYztiBYudY4fl7Efr3hgteafK5KJodCp+gIKYn6qBk25hCz+mx660je63m9LRH
         6o94tgTuCUZOztHtT16s5QtJPq8v6V73l66ByTZdm684/rbtDqLy1IqhYjopMMzLGl5y
         YaFw==
X-Forwarded-Encrypted: i=1; AJvYcCX5839ETRwhOZULXOWRa+uAxhqm6NLRs41EYEb9pNE9om5WTfdHxeoqW7udpVnyLDiACuo3AVuqLAo2lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2pHwMJ92M7IZxJyB+y7cfD603BS3J++TNBkTOMq7MEH7qNvL
	Dd0+kpwIKZe0c1/IfbQb7VAi8iEVCHFThdxTM31cENj3ibqgrcjSowBt
X-Gm-Gg: ASbGncuu/bml0hsc0nLmJ6d7e6107Ers4DfhRPczvdH+1MLlY8OeqdLJ5+flUUJbfdZ
	MDn4jSMj67XmnVX/FqT9WnqPYrIIBEhOdN3/Uz9j4dNxPNPu+tz8gOupvPANwJEw2+qiVJ+GCeG
	eE3w3AL0Cb5GW1ikKXg2H72I8E4aBDPE5pdY6neYDtGJBR8vZgIKwfI4L7mqwEppI2+/0q3tHLt
	FEqaVhtE6+uBITkwAo5+UCdxMZyqOmiUYoGlpe8RmbPppYOnJrb4NVJWsV+jBM9ZvZbsfKXnJTJ
	6RoKpmqdGfN7ybeU+ltsBFRcVg1LNwS5JVMzUnYNyFYJMaXPKjh98HFDjTgUmfEvtvwrTNvRdO6
	J93Zxju5q+glURLIsQ/NMX9EY9oq8dPmRgVmFQerVPAJoukJp/2puIQoZ31rtWnycLnx84fl9sx
	lLHvCpaJU2bz8+HOY2AWfMpBwJRDNjIiQSTrBUQ19JMERXVeZ/NunTQg==
X-Google-Smtp-Source: AGHT+IFcDWr3KBlNMXeLNPkyZZOa63IpUuqeGF/O+KRb8PWkuF5qhGuak3PkMEe642XnoKQJ5ppqRw==
X-Received: by 2002:a17:902:da8b:b0:295:2cb6:f498 with SMTP id d9443c01a7336-2952cb6f55emr159576605ad.7.1762259623021;
        Tue, 04 Nov 2025 04:33:43 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.200.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d181sm26106575ad.85.2025.11.04.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:33:40 -0800 (PST)
Message-ID: <a162ddcbd8c73adf43c7c64179db06ce60b087d6.camel@gmail.com>
Subject: Re: [PATCH 3/4] xfs: use IOCB_DONTCACHE when falling back to
 buffered writes
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>, 
	Christian Brauner
	 <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, "Martin K. Petersen"
 <martin.petersen@oracle.com>,  linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-raid@vger.kernel.org,  linux-block@vger.kernel.org
Date: Tue, 04 Nov 2025 18:03:35 +0530
In-Reply-To: <20251029071537.1127397-4-hch@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
	 <20251029071537.1127397-4-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-29 at 08:15 +0100, Christoph Hellwig wrote:
> Doing sub-block direct writes to COW inodes is not supported by XFS,
> because new blocks need to be allocated as a whole.  Such writes
Okay, since allocation of new blocks involves whole lot of metatdata updates/transactions etc and
that would consume a lot of time and in this large window the user buffer(for direct I/O) can be re-
used/freed which would cause corruptions?
Just thinking out loud: What if we supported sub-block direct IO in XFS and indeed allocated new
blocks+ update the metadata structures and then directly write the user data to the newly allocated
blocks instead of using the page cache? Assuming the application doesn't modify the user data buffer
- can we (at least theoritically) do such kind of sub-block DIO?
--NR
> fall back to buffered I/O, and really should be using the
> IOCB_DONTCACHE that didn't exist when the code was added to mimic
Just curious: How was it mimiced? 
> direct I/O semantics as closely as possible.  Also clear the
> IOCB_DIRECT flags so that later code can't get confused by it being
> set for something that at this point is not a direct I/O operation
> any more.
This makes sense to me.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5703b6681b1d..e09ae86e118e 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1119,6 +1119,9 @@ xfs_file_write_iter(
>  		ret = xfs_file_dio_write(iocb, from);
>  		if (ret != -ENOTBLK)
>  			return ret;
> +
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		iocb->ki_flags |= IOCB_DONTCACHE;
>  	}
>  
>  	if (xfs_is_zoned_inode(ip))

