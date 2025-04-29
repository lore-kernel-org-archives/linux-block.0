Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C4172767
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889136; cv=none; b=FeDN+O8kvrWKmF2zZI/vP0CCbeYdoRwUHyVMHTYQAH/Y7nEUmG+eas4HiWGPbvRoQgWTFDbUh+ZLHZzDUg83A4+RTl7S2wcOVTa/Q/+qTKNRf/+diUFCILqKYEE7+Vfs+fSNRK7CjeXABx7DDdKMn+bgrY/AO+/2yUMKg8xMvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889136; c=relaxed/simple;
	bh=8HujOxCwXXWmCeDmCYyTBIChPGHELa36gU+OXosXg9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US1Nhfjt3Zh675kBbc50QzYKTRmFgtkW2rhxWepS6QvhlRpo94W1Od7VcQMG8ZwmPcqPDcFJDPcBSsiSkHEs/DciuHWTS5MMts0FAAinD6esKJ0/f58iBv8Yx3mol0stQYKTZGjaohtEqDDRKPNDtgr1McAxCWMnrt9X4G0JbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I04fzSLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I04fzSLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745889133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSy+oRPCXjazV/uUo1lx7P018yh47TJz3P0mjl0sag=;
	b=I04fzSLuICHXQM3wEgf4GjCO2vGZohGWFfj35HONtuGM2ngAQ/kUuM2gvKnpzAAFmtL5FW
	qewLBzcFGCritQ3LZp37JL+cDBegycanVePphePo0cUB+1ISkOs4JXuTmlLJ+XClfwlDlC
	y8+It0vQWfIc4Bhp54ovkIyp4bvqzQ8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-ilqj4ZvCOS2j7x1IPN3d3A-1; Mon,
 28 Apr 2025 21:12:12 -0400
X-MC-Unique: ilqj4ZvCOS2j7x1IPN3d3A-1
X-Mimecast-MFC-AGG-ID: ilqj4ZvCOS2j7x1IPN3d3A_1745889131
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7E4F1800368;
	Tue, 29 Apr 2025 01:12:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2B0E180045C;
	Tue, 29 Apr 2025 01:12:07 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:12:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests: ublk: make test_generic_06 silent on
 success
Message-ID: <aBAnY0RhnkFXBJdK@fedora>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <20250428-ublk_selftests-v1-2-5795f7b00cda@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-ublk_selftests-v1-2-5795f7b00cda@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Apr 28, 2025 at 05:10:21PM -0600, Uday Shankar wrote:
> Convention dictates that tests should not log anything on success. Make
> test_generic_06 follow this convention.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

