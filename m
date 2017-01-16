Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36327 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdAPAT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Jan 2017 19:19:58 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so48627739pfu.3
        for <linux-block@vger.kernel.org>; Sun, 15 Jan 2017 16:19:58 -0800 (PST)
Message-ID: <1484525991.27533.31.camel@dubeyko.com>
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@ml01.01.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Date: Sun, 15 Jan 2017 16:19:51 -0800
In-Reply-To: <20170114082621.GC10498@birch.djwong.org>
References: <20170114002008.GA25379@linux.intel.com>
         <20170114082621.GC10498@birch.djwong.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-01-14 at 00:26 -0800, Darrick J. Wong wrote:

<skipped>

> Some day we'll start designing a pmem-native fs, I guess. :P

There are research efforts in this direction already ([1]-[15]). The
latest one is NOVA, as far as I can see. But, frankly speaking, I
believe that we need in new hardware paradigm/architecture and new OS
paradigm for the next generation of NVM memory. The DAX is
simple palliative, temporary solution. But, from my point of view,
pmem-native fs is also not good direction because, anyway, memory
subsystem will be affected significantly. And, finally, evolution of
memory subsystem will reveal something completely different that we can
imagine right now.

Thanks,
Vyacheslav Dubeyko. 

[1] http://pages.cs.wisc.edu/~swift/papers/eurosys14-aerie.pdf
[2] https://www.researchgate.net/publication/282792714_A_User-Level_File_System_for_Fast_Storage_Devices
[3] https://people.eecs.berkeley.edu/~dcoetzee/publications/Better%20IO%20Through%20Byte-Addressable,%20Persistent%20Memory.pdf
[4] https://www.computer.org/csdl/proceedings/msst/2013/0217/00/06558440.pdf
[5] https://users.soe.ucsc.edu/~scott/papers/MASCOTS04b.pdf
[6] http://ieeexplore.ieee.org/document/4142472/
[7] https://cseweb.ucsd.edu/~swanson/papers/FAST2016NOVA.pdf
[8] http://cesg.tamu.edu/wp-content/uploads/2012/02/MSST13.pdf
[9] http://ieeexplore.ieee.org/document/5487498/
[10] https://pdfs.semanticscholar.org/544c/1ddf24b90c3dfba7b1934049911b869c99b4.pdf
[11] http://pramfs.sourceforge.net/tech.html
[12] https://pdfs.semanticscholar.org/2981/b5abcbe1023b9f3cd962b0be7ef8bd45acfd.pdf
[13] http://ieeexplore.ieee.org/document/6232378/
[14] http://ieeexplore.ieee.org/document/7304365/
[15] http://ieeexplore.ieee.org/document/6272446/

