Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B491111BF
	for <linux-block@vger.kernel.org>; Sat, 23 Aug 2025 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755918262; cv=none; b=dCciL9LfNfd7hV7tZcWVxjoKYBgVZijLlwn0eazdporn8Cra+U71DPwuvn1oOu2rqN8rDbpLHAGrpJIyvOi9l4pdwpT/LSCRAee2KOjH3y2eSXzzojcU1QKmSs/bIRnHQXfjc3W5RSFMo8C+3XIN5PW0sfHDMprq6cNnndohYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755918262; c=relaxed/simple;
	bh=e3dZlCySrN45/V4/FSV5rzWHKwS5Dfh6QF/l4lEbPrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYDy0ccI7IlWvnBlBNu+xv3foX92EAWvasI5bCHnJ5C5jDLubTSxEUUYcAeD807tqBMA9G6zNEcccwhjd8ZjYr+Ow2ZYeMseTiC9v2N85JaACywSZpoHB3Qv1/81yGuX6XGCuA3ybx5sFgQ22UPMi02ZxwxutForT5KkNmxBzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcOM2I8s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcOM2I8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755918260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mX3NAGtHuGVyQ3eRets320CnOXnaI6I/a3SgIRIekLs=;
	b=hcOM2I8sXBnKfzlipWr78aVq7lQwO5qKW+RjTs6Mn8raaD1AWJakC2BOuNvqzXElo2bU+8
	b1xHHhv/zazHPX1DWMmM/LXfP6P7ggH2Iynp6Es1PnPIH7AhIhbnc7qWiZ/oFsFxePTXqW
	vyqo4YZdIr9ESuw+Al7xLQloC4hfNPs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-RL1KOhSrN3u86sb4_TDg5Q-1; Fri,
 22 Aug 2025 23:04:16 -0400
X-MC-Unique: RL1KOhSrN3u86sb4_TDg5Q-1
X-Mimecast-MFC-AGG-ID: RL1KOhSrN3u86sb4_TDg5Q_1755918255
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F39F21956087;
	Sat, 23 Aug 2025 03:04:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A77019560B0;
	Sat, 23 Aug 2025 03:04:10 +0000 (UTC)
Date: Sat, 23 Aug 2025 11:04:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: rename min_segment_size
Message-ID: <aKkvpkt-yoEU1gvQ@fedora>
References: <20250822171038.1847867-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822171038.1847867-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 22, 2025 at 10:10:38AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Despite its name, the block layer is fine with segments smaller that the
> "min_segment_size" limit. The value is an optimization limit indicating
> the largest aligned segment that can be used without considering segment
> boundary limits, so give it a name that reflects that.

Yeah, it is right.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

