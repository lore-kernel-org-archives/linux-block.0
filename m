Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF82C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 19:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD27611EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 19:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbhI1T5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbhI1T5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 15:57:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E6C06161C
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 12:55:21 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h129so145345iof.1
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1dkOoEowsVEai15whHpEaoKklD3em5dZIMAiSQ/NBXA=;
        b=ZeD06VESIVwTz1xeRXSBHGWRRwsuqhJZqQwA7cS8w7S36OQJ9M42GPOt60GoPm4LLN
         EhyE/ygXrJFIONCKDGKyPvXji5TLlEPtth9nQsRZuy/IeYGcjbWWP7tWPdZ/g49vlVEV
         D4ziTYxHr8njp8La9hvWgYGQygcfX8fs0pN+lyR+t1RqdyHwC/7j9ctRh39DBoSxrCAF
         W7fZNVt8JY3zn5Gg4p3VkhBgFht+DBRN4Umj8cH8EE9Lo3YE6taSK+G2eOxlcDNL8a69
         u/eiBSoiyJw8GFFxy3BA4RXuA7thqLvfHkJROM11lKZey1rvl8Ml9UFTDNyZ2L/Vl66Z
         9YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1dkOoEowsVEai15whHpEaoKklD3em5dZIMAiSQ/NBXA=;
        b=8P2v1+JlFLF4yAbB9fhLfcKTeFeOANzo2uEwxQAf8QEmCaJ+TLeoZHt2YtORH9GmF8
         5E5QDuB4rQpJrhAN1svv1OUSJMtuHZBYzHbGitzajnO2nCYvxe/NzttGVelfdS1NsrhG
         dTGTFZIB8hkb7dbevY9sckOBuzMfnY0OV0UVy+cfOop0OT52B34i72UUMCW8Gb2BiyZ9
         hXhC8+LGUMxUk8k8Vgr6LRuxwPmrGkJhb3dGkrpNn9+Y8LHxyUThG3NDyBZfudGcCN58
         +JYxAWCh2r+92nHlJd5TTP69hJpzks/eSAL3ePNtZdHWBt0a8fnEVc3CLYDhZD0cXF+a
         e/OA==
X-Gm-Message-State: AOAM531FEBa9Iy2bMcnaOz7LKhLsclQOZeT0BMoqzYjQmKf4QadQ0yM5
        052QbhMYvrcT8nC6fIAqxj/TIw==
X-Google-Smtp-Source: ABdhPJxDG+imIW+LC31md8sJ9W5FJ6CYFuQFlJipqlnxhkrntzvi5fuKARgO5VrFwZOn9a7R7YqD3w==
X-Received: by 2002:a5e:c018:: with SMTP id u24mr5346781iol.129.1632858920781;
        Tue, 28 Sep 2021 12:55:20 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r20sm30511ioh.19.2021.09.28.12.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:55:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVJCA-007Gjs-VN; Tue, 28 Sep 2021 16:55:18 -0300
Date:   Tue, 28 Sep 2021 16:55:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210928195518.GV3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-20-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:
> +int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
> +{
> +	struct pci_p2pdma_map *pmap;
> +	struct pci_p2pdma *p2pdma;
> +	int ret;
> +
> +	/* prevent private mappings from being established */
> +	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
> +		pci_info_ratelimited(pdev,
> +				     "%s: fail, attempted private mapping\n",
> +				     current->comm);
> +		return -EINVAL;
> +	}
> +
> +	pmap = pci_p2pdma_map_alloc(pdev, vma->vm_end - vma->vm_start);
> +	if (!pmap)
> +		return -ENOMEM;
> +
> +	rcu_read_lock();
> +	p2pdma = rcu_dereference(pdev->p2pdma);
> +	if (!p2pdma) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
> +			    &pci_p2pdma_fs_cnt);
> +	if (ret)
> +		goto out;
> +
> +	ihold(p2pdma->inode);
> +	pmap->inode = p2pdma->inode;
> +	rcu_read_unlock();
> +
> +	vma->vm_flags |= VM_MIXEDMAP;

Why is this a VM_MIXEDMAP? Everything fault sticks in here has a
struct page, right?

Jason
