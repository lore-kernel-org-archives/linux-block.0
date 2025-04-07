Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD2212D7C
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995688; cv=none; b=VntD6QdkqkkiiJcXRnQvxor3I7m5P2Te7aqDcrxLlWt8BDVWnniTS6rDaCN0K2JaCwxvqHUQ990JlS/XeOZa4qoS7ZLa+AaKR96LqLlUsyIGOSGB+RMe47XfUDk6oYsFE+gRmN5aHXb5ZaWoMEEb6D+6RlFXx7XpihuvE+nITZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995688; c=relaxed/simple;
	bh=sVADC9t02NK/PBXcvZHWnn5Ky2/XCS1yjMFbOHdv35Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIMAiAL3sd75+DAmjOG0WHmnOeg2Ad1SxOYmeHWI6U1hDpRHHLoI2sTsWaioKvx+EDAV8tP9pv6fJNr2QS8YCEpzsQXqbzdD32Mro7E39t2C3eKD2ledVHTopgWWRagLPXWqgm+KI7XvbL1Ekzipfu0r7Y5a/3HPUNO0+YIZQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+apFH75; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+apFH75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743995685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGr5wYrkWQVMv452r08m9/hBCcacPt3XTCSt2EEHlyo=;
	b=Y+apFH75X35dP0i8Q34mgww5QrOGeUVS10KwFUtzllvXOFAjMJXFI9zaPF7iZFIxXmYZh5
	/WGIGCnLQcS2/0Gwn/9nuwkqPvtqaL089IgtIQswwb5C5Y+jG9Ti1oBEq42PSd8eK0tfVB
	03dxwQqNtdmSVlmka/4BPh9O2ObeOVI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-ZBOuUOuFNjuGRINoaibe0A-1; Sun,
 06 Apr 2025 23:14:43 -0400
X-MC-Unique: ZBOuUOuFNjuGRINoaibe0A-1
X-Mimecast-MFC-AGG-ID: ZBOuUOuFNjuGRINoaibe0A_1743995683
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD9C8195609E;
	Mon,  7 Apr 2025 03:14:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EB0A180094A;
	Mon,  7 Apr 2025 03:14:39 +0000 (UTC)
Date: Mon, 7 Apr 2025 11:14:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] ublk: Add UBLK_U_CMD_SET_SIZE
Message-ID: <Z_NDGl6Le--pPBxR@fedora>
References: <20250331135449.3371818-1-jholzman@nvidia.com>
 <SJ1PR12MB63639AFCE9BC8C1EC4D28795B1AE2@SJ1PR12MB6363.namprd12.prod.outlook.com>
 <Z_Cana4Ibs8zN_wA@fedora>
 <07db9a34-c5de-4ea4-afc5-e740e87923c5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07db9a34-c5de-4ea4-afc5-e740e87923c5@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Apr 06, 2025 at 11:17:05PM +0300, Jared Holzman wrote:
> Hi Ming,
> 
> On 05/04/2025 5:51, Ming Lei wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hello Jared,
> > 
> > On Thu, Apr 03, 2025 at 12:37:11PM +0000, Jared Holzman wrote:
> > > Apologies if this is a dup, but I am not seeing the original mail on the mailing list archive.
> > I guess it is because the patch is sent as html, instead of plain test,
> > please follow the patch submission guide:
> > 
> > https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> 
> Sorry about that, I originally sent the mail using git send-mail, but our
> internal smtp relay does not support outside addresses. I then tried
> forwarding it from Outlook and it decided to add HTML without telling me.
> 
> I'm using Thunderbird now, so hopefully it will be in plain-text as
> required.
> 
> > > ________________________________
> > > From: Jared Holzman <jholzman@nvidia.com>
> > > Sent: Monday, 31 March 2025 4:54 PM
> > > To: linux-block@vger.kernel.org <linux-block@vger.kernel.org>
> > > Cc: ming.lei@redhat.com <ming.lei@redhat.com>; Omri Mann <omri@nvidia.com>; Ofer Oshri <ofer@nvidia.com>; Omri Levi <omril@nvidia.com>; Jared Holzman <jholzman@nvidia.com>
> > > Subject: [PATCH] ublk: Add UBLK_U_CMD_SET_SIZE
> > > 
> > > From: Omri Mann <omri@nvidia.com>
> > > 
> > > Currently ublk only allows the size of the ublkb block device to be
> > > set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> > > 
> > > This does not provide support for extendable user-space block devices
> > > without having to stop and restart the underlying ublkb block device
> > > causing IO interruption.
> > The requirement is reasonable.
> > 
> > > This patch adds a new ublk command UBLK_U_CMD_SET_SIZE to allow the
> > > ublk block device to be resized on-the-fly.
> > Looks CMD_SET_SIZE is not generic enough, maybe UBLK_CMD_UPDATE_PARAMS
> > can be added for support any parameter update by allowing to do it
> > when device is in LIVE state.
> 
> That's fine, but we'd rather not take on the burden of verifying all of
> ublk_params to see which ones can be safely changed on-the-fly.
> 
> Would it be reasonable to have UBLK_CMD_UPDATE_PARAMS accept a different
> struct "ublk_param_update" which contains only the parameters that can be
> updated in the LIVE state and will include only max_sectors for now?
> 
> Alternatively if you know off the top of your head which parameters can be
> easily changed on-the-fly and we will add only those.
 
Fair enough, updating 'dev_sectors' should be generic enough, and it looks
fine to add UBLK_U_CMD_SET_SIZE.

In future, if there is requirement for updating other parameters, we can
add UBLK_U_CMD_UPDATE_PARAMS, and most of parameters should be allowed to
update.


Thanks,
Ming

