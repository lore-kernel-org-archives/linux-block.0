Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46063 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbdALNoO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 08:44:14 -0500
Date: Thu, 12 Jan 2017 14:44:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>
Subject: Re: [Regression] fstrim hangs on Hyper-V: caused by "block:
        improve handling of the magic discard payload"
Message-ID: <20170112134412.GB15178@lst.de>
References: <MWHPR03MB26693D8327D27CA1CFDA50A8BF790@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB26693D8327D27CA1CFDA50A8BF790@MWHPR03MB2669.namprd03.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Dexuan,

sorry for dropping the ball on the previous private report, I hoped
I could get my hands on a Hyper-V VM and reproduce it myself, but
that has obviously not happened.

Can you send me the output of the provisioning_mode file for the
scsi disk in question to get started?
