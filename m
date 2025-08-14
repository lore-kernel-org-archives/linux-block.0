Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4531D5151
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148481; cv=none; b=fVJDGxeG7ITH02KRjLACZX6BYmDUSY5HHJ/a2ThKvT653Udn9JIQUw1LAGf9cXeAre9FkU14m4NjoIKELB2zDh7y73vCKPrFVhcV86yTmiGusWq5+yjLMUKN/J/+aQCKyXtKuWMym40gNBVP07H5tFaRIT1BXhCHoDKlMNLJ7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148481; c=relaxed/simple;
	bh=J0wlzG2blZCeTmTiWa0IPgMiQWx4MedEXGLbkPJW+l8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AytT+oQ4lM/qUcpqHInCT0XPC7B95YhjX6HutK9yk4fsQUSF60oST45K6ODL8BrkDML9hDjgw5fC79Tg4N1XkW1Ktmb00Q1EQ1MuV8lezjlqGlFdrWIu3ATUgWrB1HgWHguUeg/7svpabCSg7PB4e2KJ6OqWKkzqs1zo0Avdh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhDzHSnY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhDzHSnY"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb79db329so70603666b.2
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 22:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755148478; x=1755753278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uGsl3pnIyWXTWmUAjKXVJmJrasAdmvyqWB4GlgpgknE=;
        b=EhDzHSnYX6Hpf81d2XCpC6XhS76dwOfzwWP5uBOkFTTyJTbGPPQiFFVj/pdHETtdM8
         CEg7CabsrpnIH0inpRmSPGlY75m43syl8M2OOpcFzhLhAMc7O/LiXUpX4S95ghLSgXBN
         CSpnzXsHfODpgmCU9iRcw9FtBNslCAkVCAds1ei+WHu4XQH1MDI79vwuu0c/5T65ybr+
         v69+13YjXmCbBX7siYmN0ZBCR8oqoMEG0ZVoDdEimeWnA4tpYbq6/BUvoqHsi68CgD71
         Wyn4Ac2mlyuTz16RsAL3B0hqOrpG6yKAKe6zRvYW89DGPPq5poZYkD1bK4Q2+cG4EPQO
         gGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755148478; x=1755753278;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGsl3pnIyWXTWmUAjKXVJmJrasAdmvyqWB4GlgpgknE=;
        b=eU6tMZrUIUbP1M1Na31ettnuvhVpxtwk4kNqlwRqcGilCkoIFMN034S8KhFDSPVgvT
         1/s9svqMv9Y3VXzqPT05uErMyyiB7X8+EWvNfgD/+/m2NawSyPYfpCnumKJhk0/nzCIc
         GPPgzSyb5tiRckeB/SKzJeACWfxGvF4k48wDMpkB4kkXKeNaYXYg5/AYPlT8pWaM6ANN
         C3GQNmjec310q4ELTRSe/grGxSNi1azi1/WFM8PoV4er1AIIaJS0bBVukykjvQ0ljyDE
         ZwUXmtZb+3U+EbrgKJVBwXTgG9kVxIPA3obJHQuax+BIrt7CNLkOLUqmnBf4M2690ZJb
         l2Xg==
X-Gm-Message-State: AOJu0YxSNfk/ISho41+ApreJD+fk0udhB17tznLsoe2rvs/ISHxxx1ZJ
	QNPv6gACQIIaPKpIVARt1Z5W9eMIu6KsWxzIWbhxXNfDEdlZehsRAGURMyJvnEQwq8OJWYJDSPM
	DDXXi0Mm8njWeE886afQ6yByjELGDx2h5a3zc
X-Gm-Gg: ASbGncu+E0oBvAtsfKnnLPVpEWmyWcv71cVD6tLNjvfn4lYSKtM6KCgMnAwsn9WIUED
	Covhd/V6cGvDXhAsqFWkXdBQ1g27G5wiX4Ea6owvu0hnbmCrHq33tQZmOb/PLbWHD78tN5NV9er
	nupfLTmOV/x/SPCHDmX2ZYVkRnnrBLRVH9tSB5YoEJm8RSgFjRBUboeCRBoXWT1+s9FHZS35bTE
	IciBQQe
X-Google-Smtp-Source: AGHT+IGALsMaupQw9S0qNVZ+0oLz0FQiLZsgHRri+k/J1bv5hppxqu0GISgCgYrVEbGvIEVU669Ul4syTu5spkGL/gw=
X-Received: by 2002:a17:907:3e1d:b0:af9:5ca0:e4fe with SMTP id
 a640c23a62f3a-afcb999f066mr148069566b.56.1755148477774; Wed, 13 Aug 2025
 22:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Teng Qin <palmtenor@gmail.com>
Date: Thu, 14 Aug 2025 01:14:27 -0400
X-Gm-Features: Ac12FXzzHFvWXMHDM_QM9EWcU-sPU8GS9ZOK4bDaOBMfqXYO_LQaHBmOMMFPqtg
Message-ID: <CAHumS0BE_28D47d3Ls5PJBONTzVUCA54QwTV5UhJdDhnfCEi4A@mail.gmail.com>
Subject: Question on setting IO polling behavior and documentations
To: linux-block@vger.kernel.org, hch@lst.de
Cc: inux-nvme@lists.infradead.org, axboe@kernel.dk, sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"

Hello maintainers,
I'm trying to explore and test IO polling behavior of block devices
in my system, NVMe drives to be specific. Upon trying, I noticed the
legacy /sys/block/<disk>/queue/io_poll no longer changes the polling
behavior of the device correctly.

I found out the change from
  a614dd228035 block: don't allow writing to the poll queue attribute
(https://lore.kernel.org/all/20211012111226.760968-16-hch@lst.de/)
The dmesg prompts user to use driver specific parameters, but for this
case, I can not find, either from code or documentation, parameter
from the nvme driver to set polling behavior for the drive similar to
the legacy io_poll sysfs interface.
I realized I can use flags from either io_uring or the nvme passthrough
commands to specify polling behavior. But are there still some configs
I can make to change the entire drive's IO to polling, so that legacy
applications not using io_uring can still have it?
Upon reading the entire patch set, it feels to me that since we are
changing the polling control to a per-bio flag, is drive-wide control
of polling behavior just straight-out impossible now?

Moreover, the block layer documentation at
  Documentation/ABI/stable/sysfs-block
still documents the legacy behavior of the io_poll sysfs file. This is
confusing for users trying to figure out reason of the failed or
unexpected behavior after writing to the file and seeing the dmesg,
particularly because there are many articles on the Internet describing
the legacy behavior.
If the maintainers agree, I can help update these documentations.

Thanks a lot for your kind help!

Teng Qin
