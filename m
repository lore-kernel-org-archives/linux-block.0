Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50352 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935913AbdGTP1n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2017 11:27:43 -0400
Date: Thu, 20 Jul 2017 11:33:46 -0400
From: Keith Busch <keith.busch@intel.com>
To: Benoit Depail <benoit.depail@nbs-system.com>
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        xen-users@lists.xen.org, WebDawg <webdawg@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
Message-ID: <20170720153346.GC1202@localhost.localdomain>
References: <5554bd39-6e0a-5c17-2b64-bb80d4a6502b@nbs-system.com>
 <CAKdd5H9f_=NCYMmhLcvHKFw7m_sKvygSVqz3+Z0YPAGiPMxKxQ@mail.gmail.com>
 <5b562ef2-36e2-a08e-1683-6ffc7cfa54de@nbs-system.com>
 <20170717124931.rsiqxkzzkmvfofd7@MacBook-Pro-de-Roger.local>
 <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
 <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 20, 2017 at 05:12:33PM +0200, Benoit Depail wrote:
> 
> The main issue we are seeing is degraded write performance on storage
> devices of Xen PV DomUs, about half (or even a third on our production
> setup where NFS is involved) of what we used to have.

Read performance is unchanged?
