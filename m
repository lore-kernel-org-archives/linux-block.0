Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D6C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA572077B
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XNRLx+/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDZOpo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:45:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40602 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOpn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 10:45:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3QEYTmS120579;
        Fri, 26 Apr 2019 14:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=LE9A4smiUcCKHhSGSOEPiRFSN9l8MMhyxEeH0NKsxbs=;
 b=XNRLx+/7PRD7ym+fUsYzMt4wfLPh6UCuLh8UnZvF78EJKnzruNlOdccbiJhgIe5kl7iY
 /9OEHv5GBUe4aq9tvnaP5wYY5IbDsy5yihOkZoZCkrAW7ZA1xqgEUUx+NajOUoPXuKJ9
 C2AMf75B4eucFzdtrJ7zycj0pu3kEKwUlztJlb3v84VlNwiqroxJ6fOvRI7FmTSAZIvF
 zMdqTAl0Z3VewQl2Ja7q9uniTaJIEhuHFZ+qwCCMXvMN8MyY/sD+80Vtope085wYE5sD
 nc+bGpF/Uv68G9ZIaDzryOOFJ2dpdAmebCxw9dP4Zl/qBP8mOQpadPQIboCcOl4IgIJM BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2ryrxder02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 14:45:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3QEipin179053;
        Fri, 26 Apr 2019 14:45:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s0dwg2app-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 14:45:09 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3QEj7FI016013;
        Fri, 26 Apr 2019 14:45:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Apr 2019 07:45:07 -0700
Date:   Fri, 26 Apr 2019 07:45:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Direct block mapping through fs for device
Message-ID: <20190426144507.GB178347@magnolia>
References: <20190426013814.GB3350@redhat.com>
 <20190426062816.GG1454@dread.disaster.area>
 <20190426124553.GB12339@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426124553.GB12339@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9238 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904260101
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9238 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904260101
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 05:45:53AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 26, 2019 at 04:28:16PM +1000, Dave Chinner wrote:
> > i.e. go look at how xfs_pnfs.c works to hand out block mappings to
> > remote pNFS clients so they can directly access the underlying
> > storage. Basically, anyone wanting to map blocks needs a file layout
> > lease and then to manage the filesystem state over that range via
> > these methods in the struct export_operations:
> > 
> >         int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
> >         int (*map_blocks)(struct inode *inode, loff_t offset,
> >                           u64 len, struct iomap *iomap,
> >                           bool write, u32 *device_generation);
> >         int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
> >                              int nr_iomaps, struct iattr *iattr);
> 
> Nipick:  get_uuid isn't needed for the least itself, it just works
> around the fact that the original pNFS/block protocol is braindead.
> The pNFS/SCSI prototocol already switches to a device UUID, and other
> users that work locally shouldn't need it either.

Hmmm, this lease interface still doesn't support COW, right?

(Right, xfs_pnfs.c bails out with -ENXIO for reflink files)

It occurs to me that maybe we don't want Goldwyn's IOMAP_DAX_COW
approach (hide the read address in the iomap->inline_data pointer); we
just want two physical source addresses.  Then the dax code can turn
that into a memory pointer and file lessees can do sector accesses or
whatever they need to do to write the range before calling
->commit_blocks.

Oh, right, both of you commented about a dual iomap approach on the v2
btrfs dax support series.

/me goes back to drinking coffee.

--D
