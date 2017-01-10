Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35868 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762257AbdAJNGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2017 08:06:15 -0500
Received: by mail-pf0-f194.google.com with SMTP id b22so12586444pfd.3
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2017 05:06:15 -0800 (PST)
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
To: Theodore Ts'o <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <20170104165745.7uuwl6phm6g6kouu@thunk.org>
 <1b457b77-34d8-ab82-ae1d-279e86053af9@wdc.com>
 <20170110042442.ixxxi4yhj5gu7byh@thunk.org>
Cc: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Matias Bjorling <m@bjorling.me>
Message-ID: <ddeefd67-afb6-72a4-f59b-6fe623fbfbc3@bjorling.me>
Date: Tue, 10 Jan 2017 14:06:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170110042442.ixxxi4yhj5gu7byh@thunk.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/10/2017 05:24 AM, Theodore Ts'o wrote:
> This may be an area where if we can create the right framework, and
> fund some research work, we might be able to get some researchers and
> their graduate students interested in doing some work in figuring out
> what sort of divisions of responsibilities and hints back and forth
> between the storage device and host have the most benefit.
> 

That is a good idea. There is a couple of papers at FAST with
Open-Channel SSDs this year.  They look into the interface and various
ways to reduce latency fluctuations.

One thing I've heard a couple of times is the feature to move the GC
read/write process into the firmware. Enabling the host to offload GC
data movement, while the keeping the host in control. Would this be
beneficial for SMR?

-Matias
