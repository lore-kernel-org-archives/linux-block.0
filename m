Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BD1A5A2
	for <linux-block@vger.kernel.org>; Sat,  2 Mar 2024 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395996; cv=none; b=NfIyoTONy7QbqKEtjVHkYQkV0aNlOIdVGYk3Ei0v4p3AQ/QZ042PvI7K5j1WJ4QlkTBi4J4S5UwGBBzE2TM+gGL3ZKQPUZQX5FYUlC7I+hQ7fJfjaJcgtRLZod54pKa3EPxK76+iqLHYTGpVcfVY7w7MaGnjiet4a6HbbZ1Sg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395996; c=relaxed/simple;
	bh=FbjTuTWqBDQsWRS0dZyGAKYtWVxCCDP+Jy5p1Tkb6xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sthCwGW9Jj0ftW2E4QGiHaDBouBsJCGNhm1CSURuQmvDTPd7lJAjJwPoxnKKFBzmiLjYHNAYQXOfmBgTUheoh47vrG+dzet0j4KrICpdxHxa98rGEafLspyIZ5tgOpRA76eLNGaBMMFB2wOU564WGDrw2T+K4C8f+sSQZWYHXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a11dea5bbaso239319eaf.2
        for <linux-block@vger.kernel.org>; Sat, 02 Mar 2024 08:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709395993; x=1710000793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z4aaL+eoV7uAuWVMK9/aYASmrv+Wksdp8IvJ6mzxpQ=;
        b=jbEDILU0JPvjR/f6b0S7j1BUTHl2Wk3wwnHG/M6xNK/ZKRdMZgUUy2JmPK6mL7EJSf
         AwPldAB9vMgqrS4yhGUwdds8qwQ60jJp232l5oxPXNeCB7PvDmu6N2J7L40tC+nsuXqi
         2mKJsLfFtQt5v9wFRPZ7miTMxUU0qx43eZYKd51MahdbQ8gKMHfnpmngHOB7uL6wzyN5
         pLQ5yNi69QkryVoofMWStss9Ttgk7TQ/KR7SmglyqTbAn8LQGTO88KGQ+hfgczE7NQsB
         LgG8L6JvSdryu4M5ReLgD7ro0uUqe5sJDU/4TMY3a4d5sPBqVrICFx4InMqdC0AQaKjT
         lDwg==
X-Forwarded-Encrypted: i=1; AJvYcCWMAC4hv2tASRbRMI04YFpKEyhhJy+1rlwbO/JFF682xpfRlN3flYMC/LRdg56kffNXbnJpcwD46LwZkuml9K62yYqiANK3dfp+Yl8=
X-Gm-Message-State: AOJu0YwaK1O5MBNQ0kFlaIdiJdRvlpb48dnIJ2NfEAHD8PtTaoBQuXl2
	WduxAIkZxLX2O4kKqVAz5KVowBd7T6DYUDyJVrF51AG1y5rUj6ONWfCwdVWNnw==
X-Google-Smtp-Source: AGHT+IGf9jgOeoj362uKhi105PtehqMD4txWWxwWyWfRjF/hG3odid6G8dwTAJ8IfpCY0YN3OcPPAA==
X-Received: by 2002:a05:6358:181:b0:17b:eec9:8ee8 with SMTP id d1-20020a056358018100b0017beec98ee8mr4991319rwa.12.1709395993108;
        Sat, 02 Mar 2024 08:13:13 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id kr9-20020a0562142b8900b0068fcd643b9dsm3093596qvb.22.2024.03.02.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:13:12 -0800 (PST)
Date: Sat, 2 Mar 2024 11:13:10 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
	axboe@kernel.dk, agk@redhat.com, eparis@redhat.com,
	paul@paul-moore.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v13 13/20] dm: add finalize hook to target_type
Message-ID: <ZeNQFlw74KJ9Spdr@redhat.com>
References: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
 <1709168102-7677-14-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709168102-7677-14-git-send-email-wufan@linux.microsoft.com>

On Wed, Feb 28 2024 at  7:54P -0500,
Fan Wu <wufan@linux.microsoft.com> wrote:

> This patch adds a target finalize hook.
> 
> The hook is triggered just before activating an inactive table of a
> mapped device. If it returns an error the __bind get cancelled.
> 
> The dm-verity target will use this hook to attach the dm-verity's
> roothash metadata to the block_device struct of the mapped device.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> ---
> v1-v10:
>   + Not present
> 
> v11:
>   + Introduced
> 
> v12:
>   + No changes
> 
> v13:
>   + No changes
> ---
>  drivers/md/dm.c               | 12 ++++++++++++
>  include/linux/device-mapper.h |  7 +++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 8dcabf84d866..15b46edae49f 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2266,6 +2266,18 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>  		goto out;
>  	}
>  
> +	for (unsigned int i = 0; i < t->num_targets; i++) {
> +		struct dm_target *ti = dm_table_get_target(t, i);
> +
> +		if (ti->type->finalize) {
> +			ret = ti->type->finalize(ti);
> +			if (ret) {
> +				old_map = ERR_PTR(ret);
> +				goto out;
> +			}
> +		}
> +	}
> +
>  	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
>  	rcu_assign_pointer(md->map, (void *)t);
>  	md->immutable_target_type = dm_table_get_immutable_target_type(t);
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 772ab4d74d94..627400b2d9af 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -160,6 +160,12 @@ typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
>   */
>  typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
>  		void *addr, size_t bytes, struct iov_iter *i);
> +/*
> + * Returns:
> + *  < 0 : error
> + *  = 0 : success
> + */
> +typedef int (*dm_finalize_fn) (struct dm_target *target);

This needs some documentation, e.g.: this hook allows DM targets in an
inactive table to complete their setup before the table is made
active.

Mike

>  
>  void dm_error(const char *message);
>  
> @@ -210,6 +216,7 @@ struct target_type {
>  	dm_dax_direct_access_fn direct_access;
>  	dm_dax_zero_page_range_fn dax_zero_page_range;
>  	dm_dax_recovery_write_fn dax_recovery_write;
> +	dm_finalize_fn finalize;
>  
>  	/* For internal device-mapper use. */
>  	struct list_head list;
> -- 
> 2.43.1
> 
> 
