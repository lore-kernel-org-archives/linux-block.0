Return-Path: <linux-block-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:24224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752211AbeAaRJy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jan 2018 12:09:54 -0500
Subject: Re: [LSF/MM TOPIC] Killing reliance on struct page->mapping
To: Jerome Glisse <jglisse@redhat.com>,
        <lsf-pc@lists.linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>
References: <20180130004347.GD4526@redhat.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <111f49c1-02d1-3355-e403-a8f91c0191e2@huawei.com>
Date: Wed, 31 Jan 2018 19:09:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180130004347.GD4526@redhat.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 30/01/18 02:43, Jerome Glisse wrote:

[...]

> Maybe we can kill page->mapping altogether as a result of this. However this is
> not my motivation at this time.

We had a discussion some time ago

http://www.openwall.com/lists/kernel-hardening/2017/07/07/7

where you advised to use it for tracking pmalloc pages vs area, which
generated this patch:

http://www.openwall.com/lists/kernel-hardening/2018/01/24/7

Could you please comment what wold happen to the shortcut from struct
page to vm_struct that this patch is now introducing?


--
thanks, igor
