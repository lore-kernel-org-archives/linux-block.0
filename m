Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77071483825
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336679; cv=none; b=URLtAPJcpY3f+oTa/cn7bB/QIoP1BDnly+8EpHriV5gYB7ftFGcFBz+rdLvGNLjRifS/AJVqcCEksqMKpiHC0Ad28Lm+w8jFOt5hT1l1KzkF+6I3tXL6ceiI2HqSYxvbaH6pzqahdmf7ra1ew9fjsubnYq/trtxKN8RRkuBlINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336679; c=relaxed/simple;
	bh=PYDfl+F41hxq/6bv4+Ht5LZxugkjPCkp9xIdMHB4WZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WInkbmoOWlgsmaIFIu91/nMKMd//DmxZZ89Iye9zSjk3DWAwEYC/NTIHmITsXl4wGy4GHZeHrWHsqqhczs5orDiN6GAtX86mLtvY3XUYFSqLmevysJv7DseDNOZQDzhm2AtRQYsUPsdD24bJyZLBJ94F1t/zJvR/WaqJ5RsE2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+P97zgV; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+P97zgV"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso1119785a34.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785336675; x=1785941475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xHFMieRAasgbYmTSFjzwUgJo6vktMkwrcW3pgKwavBI=;
        b=q+P97zgV85/XuT0CsJDnZhZtKY85nDqY5wQN0sCdLcmnmhW6z3/Okro7WfBRCl0dDz
         DhE0DBNyj0HQgWb8SVDS7aZrf7Jbcj7a/ESUDzFw0TUKMNUYdJjn39VW31438+1yIlvg
         Vszj4yvBuQYJnH5fjx9doT9tm3KVzU6gj5JCYsRagGe+ZZnp3zeeHKaBB0iGkOOfKCqD
         iVimBw5RwP33sTF5d+vc3VGTCYFDRc78SR6s7+DxPI1zJ9SmLH8FjLMjg3Z7vAp7VmRN
         WkQ9VYi4v2SeGrzIYwpPss5MwociFUfp2+WZ5Y7gwWc0YUOwh/xjYTS7lKMpxMVKBXN8
         DkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336675; x=1785941475;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHFMieRAasgbYmTSFjzwUgJo6vktMkwrcW3pgKwavBI=;
        b=rdUHSlabX012Mdw0DDMpca5fgFzNljcRGMx+gZJCxEOnjusr3M/HIC4Mgab1yiYXMK
         K8oQb7A2l7uETylRze3r0+pptObrWRl9RiR67Jy0w6L9lFDxPhAoj5O6Vnbd242/k8x7
         iTTgwYF5GqC0FStL/Finb2jiadVoPuVXSzBEILMETW184dFY4OQFMODj24ks3MjIKwQ6
         w4Bvs6OHLwwVhBPiFdv0TQsBJExpjUGM9d9aluWpy8FbpxwQR8+2s8/e10oZGJCcuGvP
         TAkM/ZLkEY1InwsU5NFWrjorRKLqiFx1XfNh0efZaluBEe/dWYV017mAaF/eYlqg78xU
         tlYA==
X-Forwarded-Encrypted: i=1; AHgh+RohOPP+WUXzwEjrpqyWZcu0uRpSY3T9hhTmaWd8TaP8LV+sITX6EQb+zHSp0TQ/hMdIW/a36umgx4XzFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCDcJC1LDxKTWN+GNDA9y0WnWfawr4Br23R3wEZ3A+cVZIK3fu
	lr3ckh3tU8y78ZCHtDpNLSDOJGvbV/3K1BZTEvV2HH+5gdId6UZKzlDh
X-Gm-Gg: AR+sD12Q2xkJiSO3/sf1oT3szNzaMbILA7kCgzGxscl91K/L+jfbEh5nWCnojh/dlvK
	WWWzUCZaTA5E76gbBuq0o843a+4KsqwXNYUGG5fehVrF1I6v8xDCpblAQPeo0UwLXLHgA4Kqshv
	T3ZsX8/kCRQvpzE6DdlDj9TpvxBxovquZDx+lr3ecPlboWjUfTRDoDZZR57tW/8OoV9OGoLq9OB
	TJiAfWMVzNOIlU7K2B1oxZEXILTRvSMKtZXhqaml32rOT0VC7nMNrp1iqh10RCwkm12ozJoOah2
	HKVJbLc54hf8ZJeTUtRDoDKhSqEY/0Xjp90kxfagmpdI7xbB9iXWb/7DyLdhKL3a7R1maPy3sf+
	2vfA8uWomtwyA95Q8GplsPNOX+A0JZtaEmhHh1EjLz/sUHjI4LLbGRQlpAkfcsouBAq8+ORxLUA
	wUehZoHJKdxRGO+kbBT2Z2MqZxmqYWUHhnJFheWR7sdHxkJW7ob/Yy88qjkMpGTEyXufzg06iX5
	A3013B/PR3FYoRkz0wEehquBmw6uUvxdwVMhQrRoYUaZNg6X5LL3/C0FjLt/f25k4Td
X-Received: by 2002:a05:6830:82e3:b0:7e9:ea28:4c1f with SMTP id 46e09a7af769-7efff0c0181mr4161623a34.8.1785336674711;
        Wed, 29 Jul 2026 07:51:14 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d5f3aebsm2457915a34.9.2026.07.29.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:51:14 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:51:01 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ublk: consistently use u16 for queue and tag numbers
Message-ID: <amoTVUNipvRDGvVu@fedora-laptop>
References: <20260729012951.3744582-1-csander@purestorage.com>
 <20260729012951.3744582-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729012951.3744582-2-csander@purestorage.com>

On Tue, Jul 28, 2026 at 07:29:46PM -0600, Caleb Sander Mateos wrote:
> The u16 nr_hw_queues and queue_depth fields of the ublk UAPI struct
> ublksrv_ctrl_dev_info constrain the number of queues and queue depth of
> each ublk device. However, the ublk driver is a bit inconsistent with
> the type it uses to represent these values, mixing u16 with int and
> unsigned int. Change all queue number, queue depth, q_id, and tag
> variables/fields to u16 to save some space.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
