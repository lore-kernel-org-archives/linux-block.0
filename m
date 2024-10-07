Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67915D5C1
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298329; cv=none; b=Z1UVSA9kYJ3soRlhO+a84pFFj7Nkpssp6T6V1gzo9699GUGH0trIzRfIxgEXM8It5aYtME8XhUZYXmZ6ikEL7IXk8Dc/zu5mT+kEF8aJ952n3t8hFFPe/lRkQ8LqTLQVS4v9iYKmcUEALef6qMNqVtVtB6Mmw6b4ZVtylWL5NlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298329; c=relaxed/simple;
	bh=OQv8TKSkBKneHwnlj6/KFl1VmdSFL8uz2xD56REH1vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pE0TjSGKDKytkziISahLIATwTE/JMRWyUWBcqxKh3govIX0pLpwrvqGTthgxLnTP+yQevwr+JcVB41esRWD8htaWmweiHGENq1nuh2VpaGPmJK2kWvB9Lhir8+WNyb9Ye4Yz2ZiB5/6Ju3sALqgeM1M5cXRM6W3wXpLaUnb122Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbgcpzyQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbgcpzyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2C0C4CEC6;
	Mon,  7 Oct 2024 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298329;
	bh=OQv8TKSkBKneHwnlj6/KFl1VmdSFL8uz2xD56REH1vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jbgcpzyQ3UHKRwRnvNuzNWaDVCwEZz74oFlYh29YyWD6S/2OWtkkbaHWlyU+0QtIS
	 SIUn11wD/Ylx9WdAh91Tze1IX0045ussAcDKX4aAdLzPdZJiAEER4DWrJkqbkwEqAh
	 UfAhvGqOGxGifKkrcq5zxbPYbFNPpwx6AajyZmbrad2cem4SQkZp0rzUceEJbkipuX
	 2M2mGQYO72TzUTPypWifL1im0H67TVgIG0CKcVJy8fZKA0sWwY6PVNOLnKzIBOx9oH
	 uxGO/Uw+AGexSlMm9xIG4MqTV5fht7MXyXKSdT46jgFje4TtPNPrdeDxiIJgHznX28
	 bIy+z0sloBNXQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,  linux-block@vger.kernel.org,  "Richard W
 . M . Jones" <rjones@redhat.com>,  Ming Lei <ming.lei@redhat.com>,  Jeff
 Moyer <jmoyer@redhat.com>,  Jiri Jaburek <jjaburek@redhat.com>,  Christoph
 Hellwig <hch@lst.de>,  Bart Van Assche <bvanassche@acm.org>,  Hannes
 Reinecke <hare@suse.de>,  Chaitanya Kulkarni <kch@nvidia.com>,
  Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] block: Fix elv_iosched_local_module handling of
 "none" scheduler
In-Reply-To: <20240917133231.134806-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Tue, 17 Sep 2024 22:32:31 +0900")
References: <20240917133231.134806-1-dlemoal@kernel.org>
Date: Mon, 07 Oct 2024 12:51:50 +0200
Message-ID: <87ed4snq2h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Damien,

Damien Le Moal <dlemoal@kernel.org> writes:

> Commit 734e1a860312 ("block: Prevent deadlocks when switching
> elevators") introduced the function elv_iosched_load_module() to allow
> loading an elevator module outside of elv_iosched_store() with the
> target device queue not frozen, to avoid deadlocks. However, the "none"
> scheduler does not have a module and as a result,
> elv_iosched_load_module() always returns an error when trying to switch
> to this valid scheduler.

The commit message here is a bit misleading. The problem is not that
`request_module` can fail, the problem is that some failure modes cause
this function to return a positive integer. This is not caught by
callers and it ends up causing all kinds of problems in user space.

Perhaps it makes sense to check for a positive return value at the call
site of the `load_module` pointer in `queue_attr_store`, so this does
not repeat at some point in the future?

Or maybe document that `load_module` implementations should not return a
positive value unless it actually wants to send this to user space as
the result of a write to the `scheduler` sysfs file?

Best regards,
Andreas

