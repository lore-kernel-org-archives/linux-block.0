Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF22E8897
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315770; cv=pass; b=DV31Na9zj0JFx7FjJrGliR8q7dWJ2dGjbM5XyR2ScZo0kZaVnWdcLOI9+4W9GhxSD7X5x6h7P9AgPB9K7MS21XsIeCmtmMHQO8dnc8pD+2zuR5lhZSy0ExIzDDYv96At3Du/u4F09xoQMeyKtLgeql9OJC7OYFomKcmil6r2Hyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315770; c=relaxed/simple;
	bh=qojf+UInivScta0MoyXrvFp1klEgb6I7+kNM/9/ZWaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiwmxkNhOajMnUdUQH0n/6YYaGnfoKwZZ7y56kibLHQELceWnTkp0LOxlbYOS53wx5z2ZXGDkrT8G7tbW8tv3HLH0eqoMX/DfgLG63OkRKAQVa8txX5LmnE3t4CYoTujFrEZKllEIRu2Gd+BZ2/QRIAceltZPJ2PK2pVumT8sR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eHQ8wbLE; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eHQ8wbLE"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e5f63ab07cso87704a34.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 08:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782315768; cv=none;
        d=google.com; s=arc-20240605;
        b=KyMqvkddUjceYsZ6FxqWrRjp5igaYrhpH8HUhHQe7PPbeV7ItoSG8z/DeJrnjsdyJl
         P7wDwWgnm+CtiAxNefFtmDfEBq1Mj51ZDChI6TjRxvwFJaR7gIdYWmYvykadP+BSte74
         lT9BjeoF2qkCOKe5CZLmTasa7sHvxEroLHbct1WaGanOqB84brRlCeqzrbQIB1LKhLDE
         aCIgZToqE4oJUEHfSK3nxSybOMDEra2AS4Hlwkd5WzkCBPVG9/y6IOe5HBMxhMh2OoXB
         7mL3wGLXD4iwdIpVv6Iq2KajCx02c7CeND4Y7pzyTlxNd92iMI8nrrd/zaadOqdrJLZJ
         VyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIxzACF62I3WA/bzi3rnU9KBghHa/5yChs9BeRhT93g=;
        fh=F7vwHHfdnY9Ljg0XdLD9FbsN9Ea1BquQYqhPPg04QYE=;
        b=XyP7zWvHGTQy0Q/eVBM4buUJ0V67KBBMcqjU7azEtYPzN7fgw7CiW63iUm/4kC1d70
         S5Y+Jnt5ggP2TbXNB+o5WKzeAL6+EZAHXI06x/IljGqk6WbHqRm/YNiEPmcVA0ifkIl0
         7keD6D07K/la2hiQzXp+M/2h5++uGstHhoRrZBZC9ml95Pw6cI/92idb6odudB6RQG1G
         bNHC9iF7cH+5oG+FqYppVS5Uer5aZrSz5aV76p25h+46XU8L1twSWlWuK+dHEjBoiez5
         mg2rCVMaYEkb8f8JexLq2LFWJNhTVEFl5YoTI+XkIWjrx9EZZEv7bHbPBOVjhuJx9B8r
         E9Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782315768; x=1782920568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIxzACF62I3WA/bzi3rnU9KBghHa/5yChs9BeRhT93g=;
        b=eHQ8wbLE3jBLvH3vGH9Cckco4LVRpPZeahi2YjDPnEw+pQT47QX15ynyeuhK/FG0wn
         G+0aAuy0SRoxS7iT6kr+yNM5kQSBGuZyRZHkpnDrwIOhFwPifWb1Yab5Ay97eecekOHr
         V0NycS4yGfo08jYToHZfXckMksdtr02GHsxPhXm6OzCbj2RxHe/g4QVY7ltwX+ntrbuk
         oEmE2Yfbom7NSfWHQKtvMO+Y7bB8J4KfEvavLHYxxqhFn6eOqStA19SGcVbS78xGWXnn
         8hnrVo9DAH++hB1+pHMsTDiNQVU3Mux2hoz9DQc7TTkDBzaeV4975nbuFMxXQfKrv25P
         nL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782315768; x=1782920568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIxzACF62I3WA/bzi3rnU9KBghHa/5yChs9BeRhT93g=;
        b=Xuf4/oqUE1iDLIX9AL3LO7oMHWAoPZcb60dcHzQuYmDCmVOUE9na7xLa3A+0pimMTx
         oWb0yHJjjcoiIKcIbJvbKLigDaAZfcFJTv9Qv9fNg+MKa6y4ILiav7aYFsna+P3nlsy9
         8O0MLIsGnMTxgRpB5SWGzIWza/gMJ9JAxl30xPx3jgCtK0bry6iKjCpEuRHvQDY9G+K8
         R+8y6BLzUGSX59/tVj9rrhfALCdixqs8hg8wSfT5MZ7mK4WpfJxzsmtCSSJDYxd4P0Xb
         BeRb0fPFPm7yXjU4iTGZC3sdlabYyfus7Vro0vi9XcYDWZYIsod+C+VF00cYrB7NdAhZ
         LPjg==
X-Forwarded-Encrypted: i=1; AFNElJ+B2a+BJluavaC3GEVb+9EI+DrEVAOcvYfzteTkUHIFuzwyepYK7JBTlfVoYQgFZlQzw4Z9UptRucNUCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOF2yIdrnNn8uK1g0zTT32aA4vbotsWmLs2F9XJzLiqp0jKOVy
	9GWSQH/q7sAss0gCNY/YsiXalFMYoU3IYkNeThwEUPood6HIQHo+QqT7qP+23r9it60JOiKxfI3
	R7EJAZZzcRwS1NEHMSNqfyKfeX1RCRqtAEczpi9oELg==
X-Gm-Gg: AfdE7cnx3EP679KObfaNFMyrOqSoHorLReBSOauGkwGSwT1Qndu3tEZ9kifLQtTH7Yl
	2Tn2e74Aqxk1E7W2QQ2Zx4wN8Va9/zsMbkayn57sO6Yq4KkQtJDLj58A9hT4w0Uva2v7ajgFnx7
	uCddGyIiUcW9WQ0QCiudtYuZTIEXyNmlYxTjWIEk0/vk8uJBcSPd04bpKRkzSQcd12sFduRqGt+
	gbxuZPz6DBn3u+vi4neeoez9c4wa5qxP9F96+7wngOHB24o3LasWaATEyy7s0tfPbs6JA1whw==
X-Received: by 2002:a05:6830:3148:b0:7db:dc9e:f17e with SMTP id
 46e09a7af769-7e970b37cc6mr4773406a34.5.1782315768188; Wed, 24 Jun 2026
 08:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624080014.1998650-1-hch@lst.de> <20260624080014.1998650-3-hch@lst.de>
 <CADUfDZo4hysS6qj=Z=dEzVk=DQe6D7-zTFODLk8RGTJ13RY5uQ@mail.gmail.com> <20260624153856.GA13186@lst.de>
In-Reply-To: <20260624153856.GA13186@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 24 Jun 2026 08:42:36 -0700
X-Gm-Features: AVVi8Ceir4QUG4TercfzvNf6m62V4JP1ss0nNEMV4k4hyDwG59R7IA1gbS8d0aw
Message-ID: <CADUfDZrDNT5rVXE_zSn9-MT1YwZvN2ynCSy_zY4xt-jx_SyuTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 8:38=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Jun 24, 2026 at 08:29:07AM -0700, Caleb Sander Mateos wrote:
> > I take it 4-KB integrity intervals don't work due to the lack of
> > remapping for REQ_OP_ZONE_APPEND? Sounds like we should come back to
> > the discussion about cleaning up the ref tag seed and remapping, then.
> > I never got a reply from Martin on that thread. I guess remapping is
> > necessary at least for partitioned block devices, but we could skip it
> > for non-partitioned block devices if we initialized the ref tag seed
> > correctly.
>
> We don't actually need the partition remapping because there can't
> be partitions.  But I see on-the-wire reftag value that are 8 times
> what they should be, so there is some kind of unit mismatch that your
> series fixes.

Right, I don't mean partitions of zoned devices, but block devices in
general. I was just trying to understand why the remapping
infrastructure exists in the first place. Seems like we can't remove
it entirely, but we can at least ensure the ref tag seeds are correct
if it's skipped for a non-partitioned device.
