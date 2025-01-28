Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BC1A2387;
	Tue, 28 Jan 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082108; cv=none; b=lEBKJhwwNTUPm22vzGAPga/bKTaNiNrBFkzPXtoKMaclw5NO11M6E4OOA0nzqFIRPlvHFUg5JsrUXCvEZjyrlLhdgiyubylkqba4F/l6iONXGJRpNeBNuFLUFtyKkCrK1odgxJJRJVCCwTXWXa8xA7Ofq66+PkTTxUasZimhQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082108; c=relaxed/simple;
	bh=+i4tg6wE02L6FB7dQQmetQJ529MBj4JsPPL5ArjcfAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HHNBn7HBVO2LHX/zyE247DrxZ4ZpUREACvM607p5ny6mdFWqktkluo+T0+IkY8RvyQJmYbRy1xC87qU9VovcvOb5r6NC2j/nexOt/O/zDzN34O1IPOFzzfVIK0PFM9U/j5KD8AT1ze0MMVYTfeiG6MdtJWoliRFE29V3z4RFPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAZnRNUz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAZnRNUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E27C4CED3;
	Tue, 28 Jan 2025 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738082107;
	bh=+i4tg6wE02L6FB7dQQmetQJ529MBj4JsPPL5ArjcfAY=;
	h=From:Subject:Date:To:Cc:From;
	b=eAZnRNUzLBhTkcwUtzf/2S3oCvllOy3LSenFgcMWE/wrQeaesOAKayxCfp0izNXZf
	 hlNgDNbLJj8pTwdRmMY2lp01W0LXvElaj9Ppb4HsQgkI+ql0LwsmXKpzDt4ALy99oB
	 royjcDwmuFjjYfcqtYJ5sULcmdicMRHbYlZgTaO5o4IJU0cVFiMEI+BF3NASV9A+vx
	 vmvSjG9exCw2vCkJEbAdbxuafSu/Vr0FPqEXhLjTMJiNwXFdxQZjEktc22HJYix4z9
	 kKH0jiiEMWAi/67LoK9SNMxvaiJAZW1CPGzoHPEVNwXa+/3gZq6CgBvMDGewqbJ1lP
	 DMWILvugELCdA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/3] misc nvme related fixes
Date: Tue, 28 Jan 2025 17:34:45 +0100
Message-Id: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUHmWcC/x3LQQqAIBBA0avErBtQIZOuEi3CmWoWWjgQQXj3p
 OXj819QLsIKU/dC4VtUztxg+w7iseadUagZnHGDsS5gvhNjEo24ycOKZuRAK3nrI0G7rsJ/aNO
 81PoBU5XAV2EAAAA=
X-Change-ID: 20250128-nvme-misc-fixes-07e8dad616cd
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

While working on a patchset for TP4129 (kato corrections and
clarifications) I run into a bunch small issues:

- nvme-tcp was spamming the kernel messages, thus I think it makes sense
to rate limit those messages. I observed this with my changes, so it
might not happen that often in mainline right now but still I think it
makes sense to rate limit them.

- nvme-fc should use the nvme state accossor to ensure it always sees
the current state.

- blk_mq_tagset_wait_completed_request was hanging on ctrl deletion path
and after a bit of head scratching I figured
blk_mq_tagset_wait_completed_request does not do what it claims. After
this fix, the shutdown path works fine and I think this could go in
without my other pending stuff I am working on. As the only user of this
function is the nvme subsytem, I included in this mini series.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (3):
      nvme-tcp: rate limit error message in send path
      nvme-fc: use ctrl state getter
      blk-mq: fix wait condition for tagset wait completed check

 block/blk-mq-tag.c      | 6 +++---
 drivers/nvme/host/fc.c  | 9 ++++++---
 drivers/nvme/host/tcp.c | 4 ++--
 3 files changed, 11 insertions(+), 8 deletions(-)
---
base-commit: fd6102e646a888931ad6ab21843c6ee4355e7525
change-id: 20250128-nvme-misc-fixes-07e8dad616cd

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

