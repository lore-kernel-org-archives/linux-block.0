Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33913335077;
	Tue, 17 Feb 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333542; cv=none; b=VGiHejtMuP9WP7k0m3VZ+KuTFLuqc2VJeQbehWppVFJHegcWl6W2FIzG1dbTFkpcPJ8mix87l7G0W+rw5PB6Mao8Tn4uezkjZjOH99nfU4EgUwVOYtpnJnImMstQWZjdccrlvQn5iAzMORhSRUIi0tN5YuTC8QYmghi/KSpfClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333542; c=relaxed/simple;
	bh=hamGqIsC8rZ/FYqoaXYuXhl5LCie5VeMevUCMal2QF0=;
	h=From:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:
	 Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Type; b=Pr4DxNv4LDBu5JQaetbmdLHROHyhD2QZE9HzKnHGbyUGZ06aVQmEbPNrQCEF+FO5v4/h6XZIs3mY+x0Sv47Sj3L84VhNrQIu8cacEeSwyFeUBWV77rQd3esLxy7BdJArlLMA18MUKnMdPbNxODhX/5eknxVwHjLm86AumzgFKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTgdHzFm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTgdHzFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3216C4CEF7;
	Tue, 17 Feb 2026 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771333541;
	bh=hamGqIsC8rZ/FYqoaXYuXhl5LCie5VeMevUCMal2QF0=;
	h=From:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:
	 Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:Date:From;
	b=YTgdHzFmfDPQy6aH8mVy2avCKJ/Gf+SFs3XX/CLEwbxhbnenXQj4OM8HK2h65MMBU
	 iC3m+o8r9XiUdJlXneQTPj3fr7RV5RzFLC4rygDZphuPGOkau+3CjWTvE/xAkBsQnE
	 1kInNaRhYSc2v0lMpQzLbaeGhvB75gsgDkrUzxpYOGbIHQm+jRLlZ7WP5Dr3CXX+TP
	 9lhnSfsIKlryF8xhV/UXCptJcTdrySUpoRK7hDwQjdr0ZxNtyC6fG42NlUdX1+ac6U
	 iIMjssSyyzjBZahKTaKDxnSio2jCk7Rg+f+Vc63jKYJCBZteVCQ65WWY/7jpZA6eGs
	 a8VpA45bsa4OA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: lsf-pc@lists.linux-foundation.org
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Pittman <jpittman@redhat.com>
Cc: John Stultz <jstultz@google.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Oliver Mangold <oliver.mangold@pm.me>
Cc: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Theodore Tso <tytso@mit.edu>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: gost.dev@samsung.com
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Status of Rust in the block subsystem
Date: Tue, 17 Feb 2026 14:04:44 +0100
Message-ID: <87h5rfcyhf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I would like to propose a session to discuss the status of Rust in the block
subsystem. I have two distinct points to discuss: 1) The status of Rust in the
block layer, and 2) the out-of-tree Rust NVMe driver.


== The status of Rust in the block subsystem ==

Rust has special status in the block subsystem [1]. We are currently at "Stage
1" of a two stage "kind of thing", where enabling Rust code in the block
subsystem is essentially an experiment that can be terminated if it does not
work out. In order to move on from this stage to "Stage 2", where Rust in the
block subsystem is a first class citizen, we need two things. 1) We must observe
that Rust is applicable for writing block device drivers and 2) the kernel in
general must have fully adopted Rust.

For 1) I just sent a patch series that brings the Rust null block driver to
feature parity with the C counterpart [2]. Although the null block driver is not
real hardware, I think this submission goes a long way to demonstrate that
Rust is in fact applicable for writing block device drivers.

For 2) I would point to the fact that Rust in general is no longer experimental
in the kernel as a whole [3]. The "Rust Experiment" has been concluded,
successfully. We see adoption in the form of the binder driver, and in the
large, ongoing, effort targeting GPU drivers in the DRM subsystem. A few network
PHY drivers also made it in. There is a lot of activity on the Rust list though,
and I expect we will see Rust in more and more subsystems over the next few years.

On that basis, I suggest we discuss whether or not we can move to "Stage 2" -
and what that entails.


== The out-of-tree Rust PCI NVMe driver ==

As you may know, I am maintaining a Rust PCI NVMe driver out of tree. For the
development work of the block layer Rust APIs, it has been essential to
implement a real driver, in addition to the null block driver. A driver
targeting actual hardware has to deal with interrupts, registers, IO memory,
DMA, memory mappings, in a way that an emulated device does not. Keeping this
driver around has helped shape the Rust block APIs in a way that makes sense for
real devices, not just emulated ones.

Rebasing this driver every cycle is a lot of work. Driven by requirements of the
DRM drivers, core Rust APIs for DMA, register access, IO memory, etc. are being
reshaped and rethought, which is great. Rebasing on top of these changes as a
second class citizen all the time - not so great. But I believe that the Rust
NVMe driver is a great piece of reference code, so I keep doing it.

I would ask that we discuss merging the Rust NVMe driver so as to have a reference
implementation of a real driver in-tree. I think it would have the following
benefits:

 - It would help ensure that the Rust block layer API actually works with real
   devices.

 - It would help make sure that the changes to core APIs that are made to
   facilitate other subsystems are done in a way that is compatible with block
   layer requirements.

 - It would serve as a nice reference implementation and a great piece of
   documentation.

 - I would not have to rebase it all the time. Patches changing Rust APIs used
   by Rust NVMe would have to change the Rust NVMe call sites.

Please note the emphasis on *reference* driver. I am not suggesting to replace
the existing C driver. I will maintain the new code if necessary.

If we could establish consensus on this, I would clean up the driver to a state
where it can be included in the kernel.


Best regards,
Andreas Hindborg


Link: https://lore.kernel.org/r/593a98c9-baaa-496b-a9a7-c886463722e1@kernel.dk [1]
Link: https://lore.kernel.org/r/20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org [2]
Link: https://lore.kernel.org/all/20251213000042.23072-1-ojeda@kernel.org/ [3]

